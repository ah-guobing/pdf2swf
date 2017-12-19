#!/bin/bash

#================================================================
#   Copyright (C) 2017  All rights reserved.
#   
#   File：：install.sh
#   Author：Guo Bingbing (http://blog.webapp123.com)
#   Date：2017/12/18
#   Description：install 
#
#================================================================


#PATH=/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin:~/bin
#export PATH

dir=$(pwd)"/"
resources_dir=${dir}"resources/"
swftools_code_path=${resources_dir}"swftools-2013-04-09-1007.tar.gz"
swftools_install_dir="/usr/local/swftools/"
xpdf_code_path=${resources_dir}"xpdf-chinese-simplified.tar.gz"
xpdf_install_dir="/usr/local/xpdf/"
color_b="\033[44;36m"
color_err="\033[41;37m"
color_e="\033[0m"

#[ -f /etc/init.d/functions ] && . /etc/init.d/functions || exit 1


Get_Dist_Name()
{
    if grep -Eqi "CentOS" /etc/issue || grep -Eq "CentOS" /etc/*-release; then
        DISTRO='CentOS'
        PM='yum'
    elif grep -Eqi "Red Hat Enterprise Linux Server" /etc/issue || grep -Eq "Red Hat Enterprise Linux Server" /etc/*-release; then
        DISTRO='RHEL'
        PM='yum'
    elif grep -Eqi "Aliyun" /etc/issue || grep -Eq "Aliyun" /etc/*-release; then
        DISTRO='Aliyun'
        PM='yum'
    elif grep -Eqi "Fedora" /etc/issue || grep -Eq "Fedora" /etc/*-release; then
        DISTRO='Fedora'
        PM='yum'
    elif grep -Eqi "Debian" /etc/issue || grep -Eq "Debian" /etc/*-release; then
        DISTRO='Debian'
        PM='apt'
    elif grep -Eqi "Ubuntu" /etc/issue || grep -Eq "Ubuntu" /etc/*-release; then
        DISTRO='Ubuntu'
        PM='apt'
    elif grep -Eqi "Raspbian" /etc/issue || grep -Eq "Raspbian" /etc/*-release; then
        DISTRO='Raspbian'
        PM='apt'
    else
        DISTRO='unknow'
    fi
    Get_OS_Bit
}

Get_OS_Bit()
{
    if [[ `getconf WORD_BIT` = '32' && `getconf LONG_BIT` = '64' ]] ; then
        Is_64bit='y'
    else
        Is_64bit='n'
    fi
}


check(){
    if [ ! -d $resources_dir ];then
        echo -e ${color_err}"Error：资源目录不存在！"${color_e}
        exit 1
	fi
	if [ ! -f $swftools_code_path ];then
        echo -e ${color_err}"Error：源码包不存在！"${color_e}
        exit 1
	fi
	if [ ! -f $xpdf_code_path ];then
        echo -e ${color_err}"Error：源码包不存在！"${color_e}
        exit 1
    fi
}

install_swftools(){
	echo -e ${color_b}"准备安装swftools ..."${color_e}
	echo '   > 正在安装所需依懒...'
	if [ "$PM" = "centos" ];then
		yum -y install gcc* automake zlib-devel libjpeg-devel giflib-devel freetype-devel
	else
		apt-get -y install gcc* automake zlib-devel libjpeg-devel giflib-devel freetype-devel wget
	fi
	cd $resources_dir
	tar -zxvf swftools-2013-04-09-1007.tar.gz && cd swftools-2013-04-09-1007
	./configure --prefix=${swftools_install_dir}
	make && make install
	echo '   > swftools 安装成功 ...'
	echo '   > swftools 配置中 ...'
	echo -e "\n\n# swftools \nexport PATH=\$PATH:"${swftools_install_dir}"bin/\n\n" >>/etc/profile
	source /etc/profile
}


install_xpdf(){
	echo -e ${color_b}"准备安装xpdf ..."${color_e}
	cd $resources_dir
	tar zxvf xpdf-chinese-simplified.tar.gz
	cd ./xpdf-chinese-simplified/
	rm -rf ./add-to-xpdfrc
	echo -e "cidToUnicode   Adobe-GB1       ${xpdf_install_dir}Adobe-GB1.cidToUnicode\n" >>add-to-xpdfrc
	echo -e "unicodeMap     ISO-2022-CN       ${xpdf_install_dir}ISO-2022-CN.unicodeMap\n" >>add-to-xpdfrc
	echo -e "unicodeMap      EUC-CN       ${xpdf_install_dir}EUC-CN.unicodeMap\n" >>add-to-xpdfrc
	echo -e "unicodeMap      GBK       ${xpdf_install_dir}GBK.unicodeMap\n" >>add-to-xpdfrc
	echo -e "cMapDir            Adobe-GB1       ${xpdf_install_dir}CMap\n" >>add-to-xpdfrc
	echo -e "toUnicodeDir       ${xpdf_install_dir}CMap\n" >>add-to-xpdfrc
	echo -e "displayCIDFontTT Adobe-GB1       ${xpdf_install_dir}CMap/gkai00mp.ttf\n" >>add-to-xpdfrc	
	cp -R ../xpdf-chinese-simplified/ ${xpdf_install_dir}
	cd $resources_dir
	echo -e ${color_b}"功能演示 ..."${color_e}
	pdf2swf -s languagedir=${xpdf_install_dir} -T 9 -s poly2bitmap -s zoom=150 -s flashversion=9 ${resources_dir}"demo.pdf" -o ${dir}"demo.swf"
	
}

install_jdk(){
	java_version=`java -version 2>&1 |awk 'NR==1{ gsub(/"/,""); print $3 }'`
	java_version_main=${java_version:0:3}
	if [ `expr 100 \> $java_version_main` -eq 0 ];then
		echo -e ${color_b}"准备安装JDK ..."${color_e}
		cd $resources_dir
		if [ ! -f "jdk-8u151-linux-x64.tar.gz" ];then
			echo '   > 正在下载JDK ...'
			wget http://www.webapp123.com/soft/jdk-8u151-linux-x64.tar.gz
			echo '   > 下载成功，准备安装 ...'
		fi
		tar -zxvf jdk-8u151-linux-x64.tar.gz
		cp -R ./jdk1.8.0_151 /usr/local/
		echo -e "\n\n# JDK \nexport JAVA_HOME=/usr/local/jdk1.8.0_151" >>/etc/profile
		echo -e "export JRE_HOME=\${JAVA_HOME}/jre" >>/etc/profile
		echo -e "export CLASSPATH=.:\${JAVA_HOME}/lib:\${JRE_HOME}/lib" >>/etc/profile
		echo -e "export PATH=\${JAVA_HOME}/bin:\$PATH\n\n" >>/etc/profile
        source /etc/profile
		echo '   > 安装成功 ...'
	fi
	java_version=`java -version 2>&1 |awk 'NR==1{ gsub(/"/,""); print $3 }'`
    java_version_main=${java_version:0:3}
	if [ `expr 1.7 \> $java_version_main` -eq 0 ];then
		echo '   > 当前JDK版本：'$java_version
	else
		echo -e ${color_err}"Warn：JDK版本要求>=1.8，请手动更新JDK版本！"${color_e}
	fi
}


main(){
	Get_Dist_Name
	check
	install_swftools
	install_xpdf
	install_jdk
}

main



