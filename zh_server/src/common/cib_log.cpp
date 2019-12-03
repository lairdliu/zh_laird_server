
#include "cib_log.h"
#include <vector>
#include <sstream>
#include <fstream>
#include <sys/timeb.h>
#include <unistd.h>

//#include <sys/direct.h>
#include <sys/stat.h>
#include <iostream>
#include <unistd.h>

#include <iostream>
#include <string>
#include <sys/stat.h>
#include <errno.h>

namespace cib_tools
{
using namespace std;

//默认配置
static const string LOG_PATH = "iovroot/log/cib0.log";	//默认日志文件名称
static const int LOG_SIZE = 3;							//默认历史文件个数
static const int LOG_LEVEL = 0;							//默认日志等级
static const int FILE_SIZE = 1024*1024*20;				//默认单个文件大小

//静态成员需要初始化(静态成员初始化)
std::string CibLog::m_log_path = LOG_PATH;
int CibLog::m_log_level= LOG_LEVEL;

static vector<string> STR_LOG_LEVEL = {"ALL", "DEBUG", "INFO", "WARNING", "ERROR"};

CibLog::CibLog(const string& s, ELogLevel level, ELogWhere logWhere, char c)
{
	time_t timep;
    time (&timep);
    char tmp[64];
    strftime(tmp, sizeof(tmp), "%Y-%m-%d %H:%M:%S", localtime(&timep));
	string printStr(tmp);

	printStr.append(" : ").append(s);

	//cout << "CibLog::CibLog, s: " << s << endl;
	switch (logWhere)
	{
	case 0: // uses the defaults; prints to log file
		{
			std::ofstream ofs;
			if(CibLog::m_log_path.empty())
			{
				CibLog::m_log_path = "./"+ LOG_PATH;
			}
			//cout << "m_log_path: " << m_log_path << endl;
			ofs.open (CibLog::m_log_path, std::ofstream::out | std::ofstream::app);
			PrintString printer(ofs, '\n');
			printer(printStr); // prints s to log file
			break;
		}
	case 1:
		{
			PrintString outs(cout, c);
			outs(printStr); // prints s followed by a newline on cerr
			break;
		}
	case 2:
		{
			PrintString errors(cerr, c);
			errors(printStr); // prints s followed by a newline on cerr
			break;
		}
	default:
		{
			PrintString outs(cout, c);
			outs(printStr); // prints s followed by a newline on cerr
		}
	}
}


bool CibLog::log_init(const std::string& logPath)
{
    //0、创建路径
    system("mkdir -p ./iovroot/log");
	//1、配置日志等级
//	string le = cib_tools::CibConfig::GetParameter(cib_tools::g_strLogLevel);
//	if (!le.empty())
//	{
//		CibLog::m_log_level = atoi(le.c_str());
//	}
//	else
	{
		CibLog::m_log_level = LOG_LEVEL;
		cout << "m_log_level is empty" << endl;
		//return false;
	}

	//2、配置日志路径
	cout << "logPath: " << logPath << endl;
	if (!logPath.empty())			//不为空时修改文件路径
	{
		if (logPath[logPath.size() -1] == '/')
		{
			CibLog::m_log_path = logPath + LOG_PATH;
		}
		else
			CibLog::m_log_path = logPath + "/" + LOG_PATH;
		cout << "CibLog::m_log_path: " << CibLog::m_log_path << endl;
	}
	else
	{ 
		CibLog::m_log_path = LOG_PATH;
		if(CibLog::m_log_path.empty())
		{
			cout<<"log path is empty "<< endl;
			return false;
		}
	}
	
	//3、重命名历史日志
	std::string newLogName;
	std::string old_log_path;
	for (int i = LOG_SIZE; i > 0; i--)
	{
		newLogName = CibLog::m_log_path;
		old_log_path = CibLog::m_log_path;
		
		newLogName.replace(CibLog::m_log_path.find(".log")-1,1, std::to_string(i).c_str());
		//newLogName.insert(CibLog::m_log_path.find(".log"), std::to_string(i).c_str());

		if ((access(newLogName.c_str(), F_OK) != -1))
		{
			//删除文件
			if (remove(newLogName.c_str()) == 0)
			{
				std::cout << "remove success" << std::endl;
			}
			else
			{
				std::cout << "remove fail" << std::endl;
			}
		}
		old_log_path.replace(CibLog::m_log_path.find(".log")-1, 1, std::to_string(i-1).c_str());
		std::cout << "old_log_path: " << old_log_path << "  newLogName: " << newLogName << std::endl;
		//old_log_path.insert(CibLog::m_log_path.find(".log"), std::to_string(i-1).c_str());
		if ((access(old_log_path.c_str(), F_OK) == -1))
		{
			continue;
		}
		if (rename(old_log_path.c_str(), newLogName.c_str()) == 0)
		{
			//std::cout<<"old_log_path: "<< old_log_path << "  newLogName: " << newLogName << std::endl;
		}
		std::cout << "old_log_path: " << old_log_path << "  newLogName: " << newLogName << std::endl;
	}
	return true;
}


//日志文件创建 时间 等级 函数行数信息
void CibLog::write_log(ELogLevel level, const char* file, const char* func, int line, const char * format, ...)
{
	//检查文件大小
	FILE * logfile;
	logfile = fopen(CibLog::m_log_path.c_str(), "r");
	if (logfile != NULL)
	{
		fseek(logfile, 0, SEEK_END);
		if (ftell(logfile) > FILE_SIZE)
		{
			fclose(logfile);
			//3、重命名历史日志
			std::string newLogName;
			std::string old_log_path;
			for (int i = LOG_SIZE; i > 0; i--)
			{
				newLogName = CibLog::m_log_path;
				old_log_path = CibLog::m_log_path;

				newLogName.replace(CibLog::m_log_path.find(".log") - 1, 1, std::to_string(i).c_str());
				//newLogName.insert(CibLog::m_log_path.find(".log"), std::to_string(i).c_str());

				if ((access(newLogName.c_str(), F_OK) != -1))
				{
					//删除文件
					if (remove(newLogName.c_str()) == 0)
					{
						std::cout << "remove success" << std::endl;
					}
					else
					{
						std::cout << "remove fail" << std::endl;
					}
				}
				old_log_path.replace(CibLog::m_log_path.find(".log") - 1, 1, std::to_string(i - 1).c_str());
				std::cout << "old_log_path: " << old_log_path << "  newLogName: " << newLogName << std::endl;
				//old_log_path.insert(CibLog::m_log_path.find(".log"), std::to_string(i-1).c_str());
				if ((access(old_log_path.c_str(), F_OK) == -1))
				{
					continue;
				}
				if (rename(old_log_path.c_str(), newLogName.c_str()) == 0)
				{
					//std::cout<<"old_log_path: "<< old_log_path << "  newLogName: " << newLogName << std::endl;
				}
				std::cout << "old_log_path: " << old_log_path << "  newLogName: " << newLogName << std::endl;
			}
		}
		else
		{
			fclose(logfile);
		}
	}

	logfile = fopen(CibLog::m_log_path.c_str(),"a");
	if(logfile == NULL)
	{
		cout<<" build file faild, checkout path "<<endl;
		return;
	}

	struct  tm* ptm;
	struct  timeb   stTimeb;
	static  char    tmp[64];

	ftime(&stTimeb);
	ptm = localtime(&stTimeb.time);
    strftime(tmp, sizeof(tmp), "%Y-%m-%d %H:%M:%S", ptm);
	sprintf(tmp, "%s.%03d", tmp, stTimeb.millitm);
	string nowtime(tmp);

	const int STR_LEN = 2048;
	char m_printmsg[STR_LEN + 1];
	memset(m_printmsg, 0, STR_LEN + 1);
    va_list list;
    va_start(list,format);
//    vsprintf(m_printmsg, format, list);
	vsnprintf(m_printmsg, STR_LEN, format, list);
	va_end(list);
	//拼日志信息 时间 位置（函数名 行数）类型 信息
	if(m_printmsg)
	{
		if(level + 1 > CibLog::m_log_level)
		{
			fprintf(logfile, "[%s]:[%s]:[%s]: %d : %s : %s\n", nowtime.c_str(), file, func, line, STR_LOG_LEVEL[level].c_str(), m_printmsg);
		}
	}

	fclose(logfile);
}

}
