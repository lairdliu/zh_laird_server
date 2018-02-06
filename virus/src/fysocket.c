#include "fysocket.h"
/*******************************************************
 * CreateConnectLocaleSocket
 * 创建套接字，本地sokcet
 * pszHostString    服务器的 socket 文件
 * Returns	        成功 监听套接字 失败-1
 ******************************************************/
int CreateConnectLocaleSocket(char* pszHostString, int* pnResCode)
{
    int nConnectFd = 0;
    int nRet = 0;
    struct sockaddr_un struInAddr;
    nRet = access(pszHostString, 0);
    if (nRet != 0)
    {
//        ERROR_LOG("socket 文件[%s], errno[%d][%s]",
//                  pszHostString, errno,strerror(errno));
//        *pnResCode=errno;
        return -1;
    }
    if((nConnectFd=socket(AF_UNIX,SOCK_STREAM,0))==-1)
    {
//        ERROR_LOG("socket 创建错误!\n\t错误代码=[%d] 错误信息=[%s]",
//        errno,strerror(errno));
//        *pnResCode=errno;
        return -1;
    }

    struInAddr.sun_family = AF_UNIX;
    strcpy(struInAddr.sun_path, pszHostString);

    if(connect(nConnectFd,(struct sockaddr *)&struInAddr,sizeof(struct sockaddr_un))==-1)
    {
//        ERROR_LOG("connect 错误! 错误代码[%d] 错误信息[%s]",
//            errno,strerror(errno));
//        close(nConnectFd);
//        *pnResCode=errno;
        return -1;
    }

    return nConnectFd;
}
