/***************************************************************************
  * file name logger.h
  * brief 基础类型定义
  * date 2019/01/31
  *************************************************************************/

#ifndef CMCC_IM_LOGGER_H_
#define CMCC_IM_LOGGER_H_

#include <iostream>
#include <iomanip>
#include <fstream>
#include <string>
#include <cstdlib>
#include <stdint.h>
#include <stdarg.h>

enum ELogLevel{
    kLogLevelAll,
    kLogLevelDebug,
    kLogLevelInfo,
    kLogLevelWarn,
    kLogLevelError
};

namespace cmhi_iov{

class Logger {
   
public:
   //构造函数
   Logger() {};
   
   ~Logger() {};

   void init_logger(const std::string& file_name);

   //格式化日志输出
   static std::ostream& add(const ELogLevel log_level, const char* msg, ...);
   
private:
   static std::ostream& getStream();

   static std::ofstream m_default_log_file_;                 // 调试日志的输出流
};

#define CCLog(_log_level, _str, ...) \
do \
{ \
    if(NULL != _str) \
    { \
        std::string str = "[%s]:[%d]:[%s]";str += _str;str += "\n\0"; \
        Logger().add(_log_level, str.c_str(), __FILE__, __LINE__, __FUNCTION__, ##__VA_ARGS__); \
    } \
}while(0)

}

#endif


