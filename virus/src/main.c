/***************************************************************
 * 名           称: 病毒过滤
 * 作           者: laird
 * 创建日期: 2017-01-05
 * 修改记录:
 ****************************************************************/
#include "../include/clamav.h"
#include "fysocket.h"
#include "fyclamav.h"

int main(int argc, char* argv[])
{
    int nReturnValue;
    char* FileName="/home/liu/test.txt";
    nReturnValue = VirusCheck(argv[1]);
    if(nReturnValue == 0)
    {
        printf("文件[%s]未检测出病毒", FileName);
    }
    else if(nReturnValue == 1)
    {
        printf("文件[%s]检测出病毒", FileName);
    }
    else
    {
        printf("文件[%s]检测病毒异常", FileName);
    }
}
