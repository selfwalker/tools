#!/bin/sh

# *** comment ***
#
# install basic tools 
#
# *** end ***

#variables
Tools_Dir="/usr/local/src"
Log_File="/tmp/basic_install.log"
Error_File="/tmp/basic_install_error.log"

install_basic(){
	#clear logs
	echo "clear Log_File"
	if [ -f $Log_File ];then
	echo "Log_File $Log_File exists, remove it"
	rm -f $Log_File
	fi

	echo "clear Error_File"
	if [ -f $Error_File ];then
	echo "Error_File $Error_File exists, remove it"
	rm -f $Error_File
	fi
}
