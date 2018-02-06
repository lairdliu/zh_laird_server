#!bin/bash
echo "<?xml version=\"1.0\" encoding=\"UTF-8\"?>

<network> 
  <channelname> 
    <name id=\"1\">文件传输</name>
    <name id=\"1\">hpftest</name>
  </channelname>  
  <inner> 
    <innergateway/>
    <innerdnsgroup>
      <firstdns/>
      <seconddns/>
    </innerdnsgroup>" > /opt/jdwa/etc/network.xml

number=`sed -n '$=' /opt/jdwa/etc/nic.json`
let number=number-6
echo "number=$number"
num=0
echo "$number"
while [ ${num} -ne ${number} ]
do
        echo "<innerdev id=\"eth$num\"/>" >> /opt/jdwa/etc/network.xml
        let num=num+1
done

echo "</inner>
  <outer>
    <outergateway/>
    <outerdnsgroup>
      <firstdns/>
      <seconddns/>
    </outerdnsgroup>
    <outerdev id=\"eth0\"></outerdev>" >> /opt/jdwa/etc/network.xml

num=1
while [ $num -ne $number ]
do
        echo "<innerdev id=\"eth$num\"/>" >> /opt/jdwa/etc/network.xml
        let num=num+1
done
echo "</outer>
  <Lpoint>
    <Lpointgateway/>
    <Lpointdnsgroup>
      <firstdns/>
      <seconddns/>
    </Lpointdnsgroup>
    <Lpointdev id=\"eth0\"/>
    <Lpointdev id=\"eth1\"/>
  </Lpoint>
  <Hpoint>
    <Hpointgateway/>
    <Hpointdnsgroup>
      <firstdns/>
      <seconddns/>
    </Hpointdnsgroup>
    <Hpointdev id=\"eth0\"/>
    <Hpointdev id=\"eth1\"/>
  </Hpoint>
</network>" >> /opt/jdwa/etc/network.xml



echo "write config.xml"

echo "<?xml version=\"1.0\" encoding=\"UTF-8\"?>
<config>
        <channeltype>
                <tcp>
                        <type id=\"0\" mode=\"0\" visible=\"0\">系统</type>
                        <type id=\"1\" mode=\"1\" visible=\"0\">HTTP应用</type>
                        <type id=\"2\" mode=\"1\" visible=\"0\">SMTP应用</type>
                        <type id=\"3\" mode=\"1\" visible=\"0\">POP3应用</type>
                        <!-- <type id=\"3\" mode=\"1\" visible=\"0\">TCP</type> -->
                        <type id=\"4\" mode=\"0\" visible=\"0\">FTP应用</type>
                        <type id=\"5\" mode=\"0\" visible=\"0\">TELNET应用</type>
                        <type id=\"6\" mode=\"0\" visible=\"0\">DB</type>
                        <type id=\"7\" mode=\"0\" visible=\"0\">用户自定义应用</type>
                        <type id=\"8\" mode=\"0\" visible=\"1\">NULLTCP</type>
                        <type id=\"10\" mode=\"0\" visible=\"1\">ORACLE数据库应用</type>
                        <type id=\"11\" mode=\"0\" visible=\"0\">SQL Server数据库应用</type>
                        <type id=\"12\" mode=\"0\" visible=\"0\">TUNNEL</type>
                        <type id=\"13\" mode=\"0\" visible=\"0\">MANDATORY</type>
                        <type id=\"14\" mode=\"0\" visible=\"0\">FLUX</type>
                        <type id=\"15\" mode=\"0\" visible=\"1\">制丝集控NULL</type>
                        <type id=\"16\" mode=\"0\" visible=\"1\">MES</type>
                        <type id=\"17\" mode=\"0\" visible=\"1\">OPC</type>
                        <type id=\"18\" mode=\"0\" visible=\"0\">OPCD</type>
                        <type id=\"255\" mode=\"0\" visible=\"0\">NONE</type>
                </tcp>
                <udp>
                </udp>
        </channeltype>
        <network>" > /opt/jdwa/etc/config.xml

echo "<innerdevice num=\"$number\">" >> /opt/jdwa/etc/config.xml

num=0
while [ ${num} -ne ${number} ]
do
        echo "<dev>eth$num</dev>" >> /opt/jdwa/etc/config.xml
        let num=num+1
done

echo "<!-- <dev>man</dev> -->
        </innerdevice>" >> /opt/jdwa/etc/config.xml

echo "<outerdevice num=\"$number\">" >> /opt/jdwa/etc/config.xml
num=0
while [ $num -ne $number ]
do
        echo "<dev>eth$num</dev>" >> /opt/jdwa/etc/config.xml
        let num=num+1
done
echo "<!-- <dev>man</dev> -->
                </outerdevice>
        </network>
        <auths>
                <auth id=\"0\" visible=\"1\">安全管理员</auth>
                <auth id=\"1\" visible=\"1\">管理员</auth>
                <auth id=\"3\" visible=\"1\">审计员</auth>
                <auth id=\"2\" visible=\"1\">普通用户</auth>
                <!-- 
                <auth id=\"0\" visible=\"1\">超级管理员</auth>
                <auth id=\"1\" visible=\"1\">管理员</auth>
                <auth id=\"2\" visible=\"1\">普通用户</auth>
                <auth id=\"3\" visible=\"1\">审计用户</auth>         -->
                <!-- auth id=\"4\" visible=\"1\">强制访问用户</auth> -->
        </auths>
        <auditrights>
                <rights id=\"0\">否</rights>
                <rights id=\"1\">是</rights>
        </auditrights>

        <eventresult>
                <result id=\"0\">失败</result>
                <result id=\"1\">成功</result>
        </eventresult>

        <filenametype>
                <type id=\"47\">文件后缀名过滤</type>
                <type id=\"46\">文件前缀名过滤</type>
        </filenametype>

        <allowtype>
                 <type id=\"78\">禁止（黑名单）</type>
                <type id=\"89\">只允许（白名单）</type>
        </allowtype>


        <eventtypeext>
                <type id=\"100\" mode=\"1\">登录管理</type>
                <type id=\"1\" mode=\"0\">系统管理</type>
                <type id=\"2\" mode=\"0\">用户管理</type>
                <type id=\"3\" mode=\"0\">网络管理</type>
                <type id=\"4\" mode=\"0\">通道管理</type>
                <type id=\"5\" mode=\"0\">日志管理</type>
                <type id=\"6\" mode=\"2\">传输管理</type>
                <type id=\"7\" mode=\"0\">发送端网络管理</type>
        </eventtypeext>
        <eventtypeint>
                <type id=\"100\" mode=\"1\">登录管理</type>
                <type id=\"1\" mode=\"0\">系统管理</type>
                <type id=\"2\" mode=\"0\">用户管理</type>
                <type id=\"3\" mode=\"0\">网络管理</type>
                <type id=\"5\" mode=\"0\">日志管理</type>
                <type id=\"6\" mode=\"2\">传输管理</type>
                <type id=\"8\" mode=\"0\">接收端网络管理</type>
        </eventtypeint>

        <folder>
                <level>
                        <l id=\"0\">Top Secret</l>
                        <l id=\"1\">Secret</l>
                        <l id=\"2\">Confidential</l>
                        <l id=\"3\">Unclassified</l>
                        <l id=\"4\">confidential</l>
                        <l id=\"5\">proprietary</l>
                        <l id=\"6\">corporate</l>
                        <l id=\"7\">sensitive</l>
                </level>
                <class>
                        <c id=\"0\">0</c>
                        <c id=\"1\">1</c>
                        <c id=\"2\">2</c>
                        <c id=\"3\">3</c>
                        <c id=\"4\">4</c>
                        <c id=\"5\">5</c>
                        <c id=\"6\">6</c>
                        <c id=\"7\">7</c>
                </class>
        </folder>
        <policys>
                <policy name=\"HTTP应用\">
                        <p id=\"100\">主机地址策略</p>
                        <p id=\"101\">内容审计策略</p>
                        <p id=\"102\">访问文件类型策略</p>
                        <p id=\"103\">查询字符串策略</p>
                        <p id=\"104\">POST请求策略</p>
                        <p id=\"105\">COOKIE策略</p>
                        <p id=\"106\">脚本策略</p>
                </policy>
                <policy name=\"SMTP应用\">
                        <p id=\"200\">主机地址策略</p>
                        <p id=\"201\">邮件内容审计策略</p>
                        <p id=\"202\">发件地址策略</p>
                        <p id=\"203\">收件地址策略</p>
                        <p id=\"204\">邮件主题策略</p>
                        <p id=\"205\">附件文件类型策略</p>
                        <p id=\"206\">脚本策略</p>
                        <p id=\"207\">发送邮件大小策略</p>
                        <p id=\"208\">病毒扫描策略</p>
                </policy>
                <policy name=\"POP3应用\">
                        <p id=\"300\">主机地址策略</p>
                        <p id=\"301\">邮件内容审计策略</p>
                        <p id=\"302\">发件地址策略</p>
                        <p id=\"303\">收件地址策略</p>
                        <p id=\"304\">邮件主题策略</p>
                        <p id=\"305\">附件文件类型策略</p>
                        <p id=\"306\">脚本策略</p>
                        <p id=\"307\">接收邮件大小策略</p>
                        <p id=\"308\">病毒扫描策略</p>
                </policy>
                <policy name=\"UDP应用\">
                        <p id=\"400\">内网主机地址策略</p>
                        <p id=\"401\">外网主机地址策略</p>
                </policy>
                <policy name=\"FTP应用\">
                        <p id=\"500\">关键字过滤策略</p>
                        <p id=\"501\">文件前缀名策略</p>
                        <p id=\"502\">删除文件后缀名策略</p>
                        <p id=\"503\">上传文件后缀名策略</p>
                        <p id=\"504\">下载文件后缀名策略</p>
                </policy>
        </policys>
</config>" >> /opt/jdwa/etc/config.xml
