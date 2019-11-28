//protocol.h
#include <stdlib.h>
#include <stdio.h>

#ifndef _PROTOCOL_H
#define _PROTOCOL_H

#define NET_PACKET_DATA_SIZE 5000

/// 网络数据包包头
struct NetPacketHeader
{
    unsigned short      wDataSize;  ///< 数据包大小，包含封包头和封包数据大小
    unsigned short      wOpcode;    ///< 操作码
};

/// 网络数据包
struct NetPacket
{
    NetPacketHeader     Header;                         ///< 包头
    unsigned char       Data[NET_PACKET_DATA_SIZE];     ///< 数据
};



/// 网络操作码
enum eNetOpcode
{
    NET_TEST1  = 1,  //发送文件信息
    NET_TEST2=2     //发送文件内容
};


struct File_message
{
    char filename[100];  //文件名
    long filesize;  //文件大小
};

struct File_data
{
    char filename[100];  //文件名
    unsigned char buffer[1024]; //文件内容
};

//void my_err(const char *err_string,int line)  //自定义错误函数
//{
//    std::cerr<<"line:"<<line<<std::endl; //输出错误发生在第几行
//    perror(err_string);       //输出错误信息提示
//    exit(1);
//}

#endif


