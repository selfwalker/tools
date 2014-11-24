#!/bin/sh

# *** comment ***
#
# install wget, sqlite, python 2.7.3 tornado 4.0 
#  on an empty Centos
#
# *** end ***

#variables
Tools_Dir="/usr/local/src"
Log_File="/tmp/live_install.log"
Error_File="/tmp/live_install_error.log"

install_fundamental(){
    printf "clear Log_File\n"
    if [ -f $Log_File ];then
	echo "Log_File $Log_File exists, remove it"
	rm -f $Log_File
    fi

    printf "clear Error_File\n"
    if [ -f $Error_File ];then
	echo "Error_File $Error_File exists, remove it"
        rm -f $Error_File
    fi

    #install wget
    printf "install basic functions, eg wget ...\n"
    yum -y install wget >>$Log_File 2>&1 
 
    #install sqlite
    echo "install sqlite..."
    yum -y install sqlite-devel >>$Log_File 2>&1
    yum -y install sqlite >>$Log_File 2>&1

	#update python-devel
	echo "install python-devel..."
	yum -y install python-devel* >>$Log_File 2>&1
}

link_python273="https://www.python.org/ftp/python/2.7.3/Python-2.7.3.tgz"
Python_Dir="/usr/local/python"
install_python27(){
	cd $Tools_Dir
	echo "downloading python273..."
	wget $link_python273 >>$Log_File 2>&1
	tar zxf Python-2.7.3.tgz >>$Log_File 2>&1
	cd Python-2.7.3
	./configure --prefix=/usr/local/python273 >>$Log_File 2>&1
	[ $? -ne 0 ] && tail -30 $Log_File |tee -a $Error_Log && exit 1;
	make >>$Log_File 2>&1
	[ $? -ne 0 ] && tail -30 $Log_File |tee -a $Error_Log && exit 1;
	make install >>$Log_File 2>&1
	[ $? -ne 0 ] && tail -30 $Log_File |tee -a $Error_Log && exit 1;
	mv /usr/bin/python /usr/bin/python26
	ln -s /usr/local/python273/bin/python2.7 /usr/bin/python
	echo "setup python273 done"

	echo "fix yum..."
	sed -i 's@^#!/usr/bin/python$@#!/usr/bin/python26@' /usr/bin/yum
	echo "fix yum finished, check if yum can still not be used, /usr/bin/yum"
}

link_tornado40="https://pypi.python.org/packages/source/t/tornado/tornado-4.0.tar.gz"
Tornado_Dir="/usr/local/tornado"
install_tornado(){
	cd $Tools_Dir
	echo "downloading tornado40..."
	wget $link_tornado40 >>$Log_File 2>&1
	tar zxvf tornado-4.0.tar.gz >>$Log_File 2>&1
	cd tornado-4.0
	python setup.py build
	python setup.py install
	echo "setup tornado40 done"
}

install_fundamental
install_python27
install_tornado
