%global checkout {{checkout}}
%global __os_install_post %{nil}
%define debug_package %{nil}

Name:           uniway
Version:        {{version}}
Release:        %{checkout}%{?dist}
Summary:        .

License:        .
Source0:        uniway-%{version}.tar.gz
BuildRoot:      %{_tmppath}/%{name}-%{version}-%{release}-root
AutoReqProv: no

%description

%prep
%setup -q

%build


%install
rm -rf $RPM_BUILD_ROOT
install -d -m 755 $RPM_BUILD_ROOT/opt
install -d -m 755 $RPM_BUILD_ROOT/opt/uniway
install -d -m 755 $RPM_BUILD_ROOT/opt/uniway/bin
install -d -m 755 $RPM_BUILD_ROOT/opt/uniway/lib
install -d -m 755 $RPM_BUILD_ROOT/opt/uniway/log
install -d -m 755 $RPM_BUILD_ROOT/opt/uniway/old_log
install -d -m 755 $RPM_BUILD_ROOT/opt/uniway/script
install -d -m 755 $RPM_BUILD_ROOT/opt/uniway/workpath
install -d -m 755 $RPM_BUILD_ROOT/opt/uniway/workpathsave
install -d -m 755 $RPM_BUILD_ROOT/opt/uniway/workpathtmp
install -d -m 755 $RPM_BUILD_ROOT/opt/uniway/etc
install -d -m 755 $RPM_BUILD_ROOT/opt/uniway/conf
install -d -m 755 $RPM_BUILD_ROOT/opt/uniway/bacdir
install -d -m 755 $RPM_BUILD_ROOT/opt/uniway/bacdir/init
install -d -m 755 $RPM_BUILD_ROOT/opt/uniway/bacdir/backup
install -d -m 755 $RPM_BUILD_ROOT/opt/uniway/bacdir/rollback
install -d -m 755 $RPM_BUILD_ROOT/usr/lib/systemd/system

install -p -m 0755 uniway/bin/* $RPM_BUILD_ROOT/opt/uniway/bin
install -p -m 0755 uniway/script/* $RPM_BUILD_ROOT/opt/uniway/script
install -p -m 0755 uniway/conf/* $RPM_BUILD_ROOT/opt/uniway/conf
install -p -m 0755 uniway/etc/*.sh $RPM_BUILD_ROOT/opt/uniway/etc
install -p -m 0755 uniway/etc/*.json $RPM_BUILD_ROOT/opt/uniway/etc
install -p -m 0755 uniway/etc/*.service $RPM_BUILD_ROOT/usr/lib/systemd/system

tar -xzf uniway/lib.tgz -C $RPM_BUILD_ROOT/opt/uniway/
tar -xzf third_party/jetty.tgz -C $RPM_BUILD_ROOT/opt
tar -xzf third_party/tomcat.tgz -C $RPM_BUILD_ROOT/opt
mv -f war/ROOT.war $RPM_BUILD_ROOT/opt/tomcat/webapps

\cp -f third_party/data.tgz $RPM_BUILD_ROOT/opt/uniway
\cp -f third_party/clamav.tgz $RPM_BUILD_ROOT/opt/uniway
\cp -f third_party/sendEmail-v1.56.tar.gz $RPM_BUILD_ROOT/opt/uniway

%files
%defattr(-,root,root,-)
/opt
/usr/lib/systemd/system

%post
systemctl enable adminserver.service
systemctl enable uniway_init.service
if [ $1 -eq 2 ]; then
    echo FALSE > /opt/uniway/conf/isFirstStart
    #/opt/uniway/script/addcron
    echo "update ok"
fi

#%preun

%posttrans
systemctl enable adminserver.service
systemctl enable uniway_init.service
systemctl enable onewaygap.service
echo "install ok"

%changelog

