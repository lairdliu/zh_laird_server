#ifndef __FYCLAMAV__
#define __FYCLAMAV__

//#include <fylibc.h>
#include "../include/clamav.h"
#include <sys/types.h>
#include <sys/stat.h>
#include <fcntl.h>

#ifndef O_BINARY
#define O_BINARY	0
#endif

/*************** 扫描数据流 ********************/
typedef struct __RCVLN
{
    char buf[PATH_MAX+1024]; /* FIXME must match that in clamd - bb1349 */
    int sockd;
    int r;
    char *cur;
    char *bol;
}RCVLN;

int Sendln(int sockd, const char *line, unsigned int len);
void RecvlnInit(RCVLN *s, int sockd);
int RecvlnRsp(RCVLN *s);
int Recvln(RCVLN *s, char** rbol, char** reol);
int VirusCheck(char* pFileName);

/******************************************/

#endif

