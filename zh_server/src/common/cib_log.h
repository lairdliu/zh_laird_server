
/***************************************************************************
  * file name cib_log.h
  * brief 日志
  * date 2019/02/28
  *************************************************************************/

#ifndef __CIB_LOG_H__
#define __CIB_LOG_H__
#include <stdarg.h>
#include <syslog.h>
#include <string.h>
#include <iostream>
#include <sstream>
#include <string>
#include <stdio.h>
#include <time.h>
#include <memory.h>
#include <typeinfo>
#include <stdlib.h>

namespace cib_tools
{

class CibLog
{
public:
    enum ELogLevel
	{
		ALL,
		DEBUG,
		INFO,
		WARN,
		ERROR
	};

	enum ELogWhere
	{
		LOGFILE,
		LOGCOUT,
		LOGCERR
	};

public:
	CibLog(const std::string & s, ELogLevel level = ALL, ELogWhere logWhere = LOGFILE, char c = '\n');

public:
    CibLog() = default;
    ~CibLog(){};

    bool log_init(const std::string& logPath);		//初始化日志生成路径
    static void write_log(ELogLevel level, const char* file, const char* func, int line, const char * format, ...);		//写入日志文件

private:
    static std::string m_log_path;
    static int m_log_level;
};

class PrintString
{
public:
	PrintString(std::ostream &o = std::cout, char c = '\n') : os(o), sep(c) { }
    void operator()(const std::string &s) const
	{
		os << s << sep;
	}

private:
	std::ostream &os; // stream on which to write
	char sep;        // character to print after each output
};

#define CIBLOG(a, format, ...) cib_tools::CibLog::write_log(a, __FILE__, __FUNCTION__, __LINE__, format, ##__VA_ARGS__)
//#define ALL cib_tools::CibLog::ALL
//#define DEBUG cib_tools::CibLog::DEBUG
//#define INFO cib_tools::CibLog::INFO
//#define	WARN cib_tools::CibLog::WARN
//#define	ERROR cib_tools::CibLog::ERROR
	
}
#endif
