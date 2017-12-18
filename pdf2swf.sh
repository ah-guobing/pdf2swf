#!/bin/bash

#================================================================
#   Copyright (C) 2017  All rights reserved.
#
#   File：：pdf2swf.sh
#   Author：Guo Bingbing (http://blog.webapp123.com)
#   Date：2017/12/18
#   Description：install
#
#================================================================


file=$1
/usr/local/swftools/bin/pdf2swf -s languagedir=/usr/local/xpdf/ -T 9 -s poly2bitmap -s zoom=150 -s flashversion=9 "${file}" -o "${file}.swf"
