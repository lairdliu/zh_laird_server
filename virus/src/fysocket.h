/***************************************************************
 * 名           称 : SOCKET 通讯操作头文件
 * 作           者 : laird
 * 创建日期: 2015-04-27
 * 修改记录: 
 ****************************************************************/
 
#ifndef __FYSOCKET_H__
#define __FYSOCKET_H__

//#include <fylibc.h>

#include <sys/un.h>
#include <sys/types.h>          /* See NOTES */
#include <sys/socket.h>

#ifdef __cplusplus
extern "C" {
#endif

#define DEF_COM_TIMEOUT	60			// 通讯函数的缺省超时时间 

#define LOCAL_HOST_IP_ADDR	"127.0.0.1"

typedef struct
{
    char szIp[256];
    unsigned int nPort;
}SOCKINFOSTRU;
typedef SOCKINFOSTRU * PSOCKINFOSTRU;

/*
 * SOCKET通讯函数
 */ 		
//RESULT CreateListenSocket(PCSTR pszIpAddr,UINT nPort,PINT pnResCode);
//RESULT CreateListenSocket_r(PCSTR pszIpAddr,UINT nPort,PINT pnResCode);
//RESULT CreateConnectSocket(PCSTR pszHostString,UINT nPort,UINT nTimeout,PINT pnResCode);
//RESULT CreateConnectSocket_r(PCSTR pszHostString,UINT nPort,UINT nTimeout,PINT pnResCode);
//RESULT RecvSocketWithSync(INT nConnectFd,PSTR pszRecvBuffer,UINT nRecvBufferLen,UINT nTimeout,PINT pnResCode);
//RESULT SendSocketWithSync(INT nConnectFd,PSTR pszSendBuffer,UINT nSendBufferLen,UINT nTimeout,PINT pnResCode);
//RESULT RecvSocketNoSync(INT nConnectFd,PSTR pszRecvBuffer,UINT nRecvBufferLen,UINT nTimeout,PINT pnResCode);
//RESULT RecvSocketNoSync_r(INT nConnectFd,PSTR pszRecvBuffer,UINT nRecvBufferLen,UINT nTimeout,PINT pnResCode);
//RESULT SendSocketNoSync(INT nConnectFd,PSTR pszSendBuffer,UINT nSendBufferLenth,UINT nTimeout,PINT pnResCode);
//RESULT SendSocketNoSync_r(INT nConnectFd,PSTR pszSendBuffer,UINT nSendBufferLenth,UINT nTimeout,PINT pnResCode);
//RESULT SetSyncString(PSTR pszSyncString,UINT nLenth);
//VOID SetMaxPacketLen(INT nLenth);
//RESULT GetSocketState(INT nSockFd);
//RESULT GetSockInfo(INT nSockFd,PSOCKINFOSTRU pstruSockInfo);
//RESULT GetPeerInfo(INT nSockFd,PSOCKINFOSTRU pstruSockInfo);
//RESULT CreateLocalSocket(PSTR pszIpAddr, PINT pnResCode);
int CreateConnectLocaleSocket(char* pszHostString, int* pnResCode);

#ifdef __cplusplus
}
#endif

#endif


