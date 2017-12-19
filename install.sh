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

PATH=/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin:~/bin
export PATH

dir=$(pwd)"/"
resources_dir=${dir}"resources/"
swftools_code_path=${resources_dir}"swftools-2013-04-09-1007.tar.gz"
swftools_install_dir="/usr/local/swftools/"
xpdf_code_path=${resources_dir}"xpdf-chinese-simplified.tar.gz"
xpdf_install_dir="/usr/local/xpdf/"
color_b="\033[44;36m"
color_err="\033[41;37m"
color_e="\033[0m"

[ -f /etc/init.d/functions ] && . /etc/init.d/functions || exit 1

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
	yum -y install gcc* automake zlib-devel libjpeg-devel giflib-devel freetype-devel
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

main(){
	check
	install_swftools
	install_xpdf
}
main

