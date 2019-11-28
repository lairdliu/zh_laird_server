#include "logger.h"
#include <cstdlib>
#include <time.h>
#include <sys/time.h>
#include<unistd.h>

namespace cmhi_iov {
    
    std::ofstream Logger::m_default_log_file_;
    
    //日志保存规则：按照次数保存10次日志，每次采用到记法，需要检查文件是否存在
    void Logger::init_logger ( const std::string& file_name ) {
        //1、将旧文件重命名  删除第九个文件，重命名已有文件
        std::string newLogName;
        std::string m_log_path;
        char a[1];
        for(int i=3;i>1;i--)
        {
            newLogName=file_name;
            m_log_path=file_name;
            //重命名：检查文件是否存在，若存在，重命名，不存在则进入下一次循环
            a[0]=i+48;
            newLogName.insert(file_name.find (".log"),a);
            if((access( newLogName.c_str(), F_OK ) != -1))
            {
                //删除文件
                 if(remove(newLogName.c_str())==0)
                 {
                    std::cout<<"remove success"<<std::endl;
                 }
                 else
                 {
                     std::cout<<"remove fail"<<std::endl;
                 }
            }
            a[0]=i-1+48;
            m_log_path.insert(file_name.find (".log"),a);
            if((access( m_log_path.c_str(), F_OK ) == -1))
            {
                continue;
            }
            if (rename(m_log_path.c_str(), newLogName.c_str()) == 0)
            {
                //std::cout<<"m_log_path: "<< m_log_path << "  newLogName: " << newLogName << std::endl;
            }
            std::cout<<"m_log_path: "<< m_log_path << "  newLogName: " << newLogName << std::endl;
        }
        newLogName=file_name;
        a[0] = 49;
        newLogName.insert(file_name.find (".log"),a);
        if (rename(file_name.c_str(), newLogName.c_str()) == 0)
        {
            //std::cout<<"file_name: "<< newLogName << "  newLogName: " << newLogName << std::endl;
        }
        std::cout<<"file_name: "<< file_name << "  newLogName: " << newLogName << std::endl;
        usleep(10);
        //2、打开新的日志
        Logger::m_default_log_file_.open ( file_name.c_str ( ));
    }
    
    std::ostream& Logger::getStream ( ) {
        
        return m_default_log_file_.is_open ( ) ? m_default_log_file_ : std::cout;
    }
    
    std::ostream& Logger::add ( const ELogLevel log_level ,const char * msg ,... ) {
        //控制文件大小： 检车文件大小，若文件大于100M重新初始化文件
       
        if(m_default_log_file_.tellp ()>(1024*1024*10))
        {
            std::cout <<"size:"<<m_default_log_file_.tellp ()<<std::endl;
            m_default_log_file_.close ();
            Logger logger;
            logger.init_logger("./iovroot/log/default.log");
        }
        
        char temp_buff[10240];
        char * buff=0;
        std::string level;
        if( msg ) {
            va_list args;
            va_start( args ,msg );
            vsnprintf ( temp_buff ,10240-1 ,msg ,args );
            va_end( args );
            buff=temp_buff;
        }
        #if 0
        time_t timep;
        time (&timep);
        char tmp[64];
        strftime(tmp, sizeof(tmp), "%Y-%m-%d %H:%M:%S.%f", localtime(&timep));
        #endif
        
        struct timeval tv;
        gettimeofday ( & tv ,NULL );
        struct tm * pTime;
        pTime=localtime ( & tv.tv_sec );
        
        char sTemp[60]={ 0 };
        //snprintf ( sTemp ,sizeof ( sTemp ) ,"[%04d-%02d-%02d]:[%02d:%02d:%02d:%03d.%03d" ,pTime->tm_year+1900 ,\
            pTime->tm_mon+1 ,pTime->tm_mday ,pTime->tm_hour ,pTime->tm_min ,pTime->tm_sec ,\
            tv.tv_usec/1000 ,tv.tv_usec%1000 );
        snprintf ( sTemp ,sizeof ( sTemp ) ,"[%04d-%02d-%02d]:[%02d:%02d:%02d:%03d]" ,pTime->tm_year+1900 ,\
                pTime->tm_mon+1 ,pTime->tm_mday ,pTime->tm_hour ,pTime->tm_min ,pTime->tm_sec ,tv.tv_usec/1000);
        if( kLogLevelDebug==log_level ) {
            level=":[DEBUG]:";
        }else if( kLogLevelInfo==log_level ) {
            level=":[INFO]:";
        }else if( kLogLevelWarn==log_level ) {
            level=":[WARN]:";
        }else {
            level=":[ERROR]:";
        }
        return getStream ( )<<sTemp
                <<level
                <<buff
                <<std::endl<<std::flush;
    }
    
}


