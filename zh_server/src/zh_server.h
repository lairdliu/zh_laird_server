//
// Created by laird on 2019/11/22.
//

#ifndef ZH_LAIRD_SERVER_ZH_SERVER_H
#define ZH_LAIRD_SERVER_ZH_SERVER_H

#include<iostream>
#include<cstring>
#include<sys/stat.h>
#include<fcntl.h>
#include<unistd.h>
#include<sys/types.h>
#include<sys/signal.h>
#include<sys/socket.h>
#include<netinet/in.h>
#include<arpa/inet.h>
#include<sys/epoll.h>
#include<errno.h>
//#include"protocol.h"

#define PORT 6666   //服务器端口
#define LISTEN_SIZE 1023   //连接请求队列的最大长度
#define EPOLL_SIZE  1023   //epoll监听客户端的最大数目

class zh_server {
public:

    zh_server();

    ~zh_server();

    /// 接受客户端接入
    void acceptClient();

    /// 关闭客户端
    void closeClient(int i);

    //处理接收到的数据
    bool dealwithpacket(int conn_fd, unsigned char *recv_data, uint16_t wOpcode, int datasize);

    bool server_recv(int conn_fd);  //接收数据函数

    void run();  //运行函数

private:
    int sock_fd;  //监听套接字
    int conn_fd;    //连接套接字
    int epollfd;  //epoll监听描述符
    socklen_t cli_len;  //记录连接套接字地址的大小
    struct epoll_event event;   //epoll监听事件
    struct epoll_event *events;  //epoll监听事件集合
    struct sockaddr_in cli_addr;  //客户端地址
    struct sockaddr_in serv_addr;   //服务器地址
};

#endif //ZH_LAIRD_SERVER_ZH_SERVER_H
