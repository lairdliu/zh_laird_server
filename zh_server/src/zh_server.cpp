//
// Created by laird on 2019/11/22.
//

#include "zh_server.h"
#include "logger.h"

using namespace std;
using namespace cmhi_iov;

zh_server::zh_server()  //构造函数
{
    //创建一个套接字
    Logger logger;
    string log_file = "/default.log";
    logger.init_logger(log_file);
    Logger::add(kLogLevelInfo, "CurrentVersion: %s",CurrentVersion.c_str());
    //CCLog(kLogLevelInfo, "CurrentVersion: %s",CurrentVersion.c_str());

    sock_fd=socket(AF_INET,SOCK_STREAM,0);
    if(sock_fd<0)
    {
        //CCLog(kLogLevelError, "update chat message guid error");
        //my_err("socket",__LINE__);
    }
    //设置该套接字使之可以重新绑定端口
    int optval=1;
    if(setsockopt(sock_fd,SOL_SOCKET,SO_REUSEADDR,(void*)&optval,sizeof(int))<0)
    {
		//CCLog(kLogLevelError, "update chat message guid error: %d",__LINE__);
        //my_err("setsock",__LINE__);
    }
    //初始化服务器端地址结构
    memset(&serv_addr,0,sizeof(struct sockaddr_in));
    serv_addr.sin_family=AF_INET;


    serv_addr.sin_port=htons(PORT);
    serv_addr.sin_addr.s_addr=htonl(INADDR_ANY);
    if(bind(sock_fd,(struct sockaddr*)&serv_addr,sizeof(struct sockaddr_in))<0)
    {
		//CCLog(kLogLevelError, "update chat message guid error: %d",__LINE__);
        //my_err("bind",__LINE__);
    }
    //将套接字转化为监听套接字
    if(listen(sock_fd,LISTEN_SIZE)<0)
    {
		//CCLog(kLogLevelError, "update chat message guid error: %d",__LINE__);
        //my_err("listen",__LINE__);
    }

    cli_len=sizeof(struct sockaddr_in);
    events=(struct epoll_event*)malloc(sizeof(struct epoll_event)*EPOLL_SIZE); //分配内存空间

    //创建一个监听描述符epoll,并将监听套接字加入监听列表
    epollfd=epoll_create(EPOLL_SIZE);
    if(epollfd==-1)
    {
		//CCLog(kLogLevelError, "update chat message guid error: %d",__LINE__);
        //my_err("epollfd",__LINE__);
    }
    event.events = EPOLLIN;
    event.data.fd = sock_fd;
    if(epoll_ctl(epollfd,EPOLL_CTL_ADD,sock_fd,&event)<0)
    {
		//CCLog(kLogLevelError, "update chat message guid error: %d",__LINE__);
        //my_err("epoll_ctl",__LINE__);
    }

}

zh_server::~zh_server()   //析构函数
{
    close(sock_fd);    //关闭监听套接字
    cout<<"服务器成功退出"<<endl;
}

void zh_server::acceptClient()      //接受客户端连接请求
{
    conn_fd=accept(sock_fd,(struct sockaddr*)&cli_addr,&cli_len);
    if(conn_fd<0)
    {
		//CCLog(kLogLevelError, "update chat message guid error: %d",__LINE__);
        //my_err("accept",__LINE__);
    }
    event.events = EPOLLIN | EPOLLRDHUP; //监听连接套接字的可读和退出
    event.data.fd = conn_fd;
    if(epoll_ctl(epollfd,EPOLL_CTL_ADD,conn_fd,&event)<0) //将新连接的套接字加入监听
    {
		//CCLog(kLogLevelError, "update chat message guid error: %d",__LINE__);
        //my_err("epoll",__LINE__);
    }
    cout<<"a connet is connected,ip is "<<inet_ntoa(cli_addr.sin_addr)<<endl;
}


void zh_server::closeClient(int i)     //处理客户端退出
{
    cout<<"a connet is quit,ip is "<<inet_ntoa(cli_addr.sin_addr)<<endl;
    epoll_ctl(epollfd,EPOLL_CTL_DEL,events[i].data.fd,&event);
    close(events[i].data.fd);

}

bool zh_server::dealwithpacket(int conn_fd,unsigned char *recv_data,uint16_t wOpcode,int datasize)  //处理接收到的数据
{


    int fd;
    if(wOpcode==1)  //接收文件信息
    {
        File_message *file_message=(File_message*)recv_data;
        strcat(file_message->filename,".down");

        if((fd=open(file_message->filename,O_RDWR|O_APPEND|O_CREAT,0777))<0)
        {
            cout<<"创建文件失败"<<endl;
            return false;
        }
    }
    else if(wOpcode==2)  //接收文件内容
    {

        File_data * file_data=(File_data*)recv_data;

        strcat(file_data->filename,".down");
        if((fd=open(file_data->filename,O_RDWR|O_APPEND))<0)
        {
            cout<<"打开文件失败"<<endl;
            return false;
        }
        if(write(fd,file_data->buffer,datasize-sizeof(file_data->filename))<0)
        {
            cout<<"写入文件失败"<<endl;
            return false;
        }
        close(fd);
    }
    return true;

}

bool zh_server::server_recv(int conn_fd)  //接收数据函数
{
    int nrecvsize=0; //一次接收到的数据大小
    int sum_recvsize=0; //总共收到的数据大小
    int packersize;   //数据包总大小
    int datasize;     //数据总大小
    unsigned char recv_buffer[10000];  //接收数据的buffer

    memset(recv_buffer,0,sizeof(recv_buffer));  //初始化接收buffer


    while(sum_recvsize!=sizeof(NetPacketHeader))
    {
        nrecvsize=recv(conn_fd,recv_buffer+sum_recvsize,sizeof(NetPacketHeader)-sum_recvsize,0);
        if(nrecvsize==0)
        {
            cout<<"从客户端接收数据失败"<<endl;
            return false;
        }
        sum_recvsize+=nrecvsize;

    }

    NetPacketHeader *phead=(NetPacketHeader*)recv_buffer;
    packersize=phead->wDataSize;  //数据包大小
    datasize=packersize-sizeof(NetPacketHeader);     //数据总大小

    while(sum_recvsize!=packersize)
    {
        nrecvsize=recv(conn_fd,recv_buffer+sum_recvsize,packersize-sum_recvsize,0);
        if(nrecvsize==0)
        {
            cout<<"从客户端接收数据失败"<<endl;
            return false;
        }
        sum_recvsize+=nrecvsize;
    }

    dealwithpacket(conn_fd,(unsigned char*)(phead+1),phead->wOpcode,datasize);  //处理接收到的数据
}

void zh_server::run()  //主执行函数
{
    while(1)   //循环监听事件
    {
        int sum=0,i;
        sum=epoll_wait(epollfd,events,EPOLL_SIZE,-1);
        for(i=0;i<sum;i++)
        {
            if(events[i].data.fd==sock_fd)    //客户端请求连接
            {
                acceptClient();  //处理客户端的连接请求

            }
            else if(events[i].events&EPOLLIN)    //客户端发来数据
            {

                server_recv(events[i].data.fd);  //接收数据包并做处理

            }
            if(events[i].events&EPOLLRDHUP) //客户端退出
            {
                closeClient(i);    //处理客户端退出
            }
        }
    }
}
