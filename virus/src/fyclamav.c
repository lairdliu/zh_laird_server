#include"fysocket.h"
/***************************************************************
 * 名           称: 发送数据到 clamd 服务
 * 作           者: laird
 * 创建日期: 2017-01-05
 * 修改记录:
 ****************************************************************/
int Sendln(int sockd, const char *line, unsigned int len)
{
    while(len)
    {
        int sent = send(sockd, line, len, 0);
        if(sent <= 0)
        {
            if(sent && errno == EINTR)
            {
                continue;
            }
            DEBUG_LOG("Can't send to clamd: [%s]", strerror(errno));
            return 1;
        }
        line += sent;
        len -= sent;
    }
    return 0;
}

/***************************************************************
 * 名           称: 接收 clamd 服务 的准备工作
 * 作           者: laird
 * 创建日期: 2017-01-05
 * 修改记录:
 ****************************************************************/
void RecvlnInit(RCVLN *s, int sockd)
{
    s->sockd = sockd;
    s->bol = s->cur = s->buf;
    s->r = 0;
}

/***************************************************************
 * 名           称: 接收 clamd 服务的响应
 * 作           者: laird
 * 创建日期: 2017-01-05
 * 修改记录:
 ****************************************************************/
int Recvln(RCVLN *s, char** rbol, char** reol)
{
    PSTR eol;

    while(1)
    {
        if(!s->r)
        {
            s->r = recv(s->sockd, s->cur, sizeof(s->buf) - (s->cur - s->buf), 0);
            if(s->r <= 0)
            {
                if(s->r && errno == EINTR)
                {
                    s->r = 0;
                    continue;
                }
                if(s->r || s->cur != s->buf)
                {
                    *s->cur = '\0';
                    if(strcmp(s->buf, "UNKNOWN COMMAND\n"))
                    {
                        DEBUG_LOG("Communication error");
                    }
                    else
                    {
                        DEBUG_LOG("Command rejected by clamd (wrong clamd version?)");
                    }
                    return -1;
                }
                return 0;
            }
        }
        if((eol = memchr(s->cur, 0, s->r)))
        {
            int ret = 0;
            eol++;
            s->r -= eol - s->cur;
            *rbol = s->bol;
            if(reol) *reol = eol;
            ret = eol - s->bol;
            if(s->r)
            s->bol = s->cur = eol;
            else
            s->bol = s->cur = s->buf;
            return ret;
        }
        s->r += s->cur - s->bol;
        if(!eol && s->r == sizeof(s->buf))
        {
            DEBUG_LOG("!Overlong reply from clamd");
            return -1;
        }
        if(!eol)
        {
            if(s->buf != s->bol)
            { /* old memmove sux */
                memmove(s->buf, s->bol, s->r);
                s->bol = s->buf;
            }
            s->cur = &s->bol[s->r];
            s->r = 0;
        }
    }
}

/***************************************************************
 * 名           称: 解析 clamd 服务的响应
 * 作           者: laird
 * 创建日期: 2017-01-05
 * 修改记录:
 ****************************************************************/
int RecvlnRsp(RCVLN *s)
{
    PSTR pBol;
    PSTR pEol;
    INT nLen = 0;
    while((nLen = Recvln(s, &pBol, &pEol)))
    {
        if(nLen == -1)
        {
            DEBUG_LOG("recvln error");
            return EXCEPTION;
        }
        if(nLen > 7)
        {
            char *colon = strrchr(pBol, ':');
            DEBUG_LOG("colon[%s]", colon);
            if(colon && colon[1] != ' ')
            {
                char *br;
                *colon = 0;

                br = strrchr(pBol, '(');
                if(br)
                {
                    *br = 0;
                }
                colon = strrchr(pBol, ':');
            }
            if(!colon)
            {
                char * unkco = "UNKNOWN COMMAND";
                if (!strncmp(pBol, unkco, sizeof(unkco) - 1))
                {
                    DEBUG_LOG("clamd replied \"UNKNOWN COMMAND\". ");
                }
                else
                {
                    DEBUG_LOG("Failed to parse reply: \"%s\"", pBol);
                }
                return EXCEPTION;
            }
            else if (!memcmp(pEol - 7, " FOUND", 6))
            {
                *(pEol - 7) = 0;
                return 1;
            }
            else if (!memcmp(pEol-7, " ERROR", 6))
            {
                return EXCEPTION;
            }
        }
    }
}

/***************************************************************
 * 名           称: 对数据流进行病毒扫描
 * 作           者: laird
 * 创建日期: 2017-01-05
 * 返回值：1 检测到病毒；-1 检测出错；0 文件正常
 * 修改记录:
 ****************************************************************/
int VirusCheck(char* pFileName)
{
    INT nReturnValue = 0;
    INT nSocket = 0;
    INT fd = 0;
    INT nLen = 0;
    uint32_t szSendBuf[BUFSIZ/sizeof(uint32_t)];
    unsigned long int todo = 1024*1024*25;// 只检测文件开头 25MB
    RCVLN struRcv;
    PSTR pBol;
    PSTR pEol;
    INT nTotal = 0;
    INT nTmpError = 0;

    fd = open (pFileName, O_RDONLY|O_BINARY);
    if (fd < 0)
    {
        DEBUG_LOG("open [%s] error", pFileName);
        return EXCEPTION;
    }

    nSocket = CreateConnectLocaleSocket("/tmp/clamd.socket", &nTmpError);
    if (nSocket < 0)
    {
        DEBUG_LOG("CreateConnectLocaleSocket error[%d][%s]",
                  nTmpError, strerror(nTmpError));
        close(fd);
        return EXCEPTION;
    }

    if(Sendln(nSocket, "zINSTREAM", 10))
    {
        DEBUG_LOG("Sendln zINSTREAM erro");
        close(fd);
        close(nSocket);
        return EXCEPTION;
    }

    while((nLen = read(fd, &szSendBuf[1], sizeof(szSendBuf) - sizeof(uint32_t))) > 0)
    {
        if((unsigned int)nLen > todo)
        {
            nLen = todo;
        }

        szSendBuf[0] = htonl(nLen);
        if(Sendln(nSocket, (const char *)szSendBuf,
                  nLen + sizeof(uint32_t)))
        {
            close(fd);
            close(nSocket);
            return EXCEPTION;
        }
        todo -= nLen;
        nTotal += nLen;
        if(!todo)
        {
            nLen = 0;
            break;
        }
    }
    close(fd);
    DEBUG_LOG("nTotal[%d]", nTotal);
    *szSendBuf=0;
    Sendln(nSocket, (const char *)szSendBuf, 4);
    RecvlnInit(&struRcv, nSocket);
    nReturnValue = RecvlnRsp(&struRcv);
    if (nReturnValue != 0)
    {
        close(nSocket);
        return nReturnValue;
    }
    close(nSocket);
    return 0; // 没有检测到病毒
}


