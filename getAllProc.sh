#!/bin/bash
#### Get states on all processes on all nodes
### Exit codes:
##	0: Success
##	1: Insufficient parameters
function printUsage
{
	echo "Invalid parameters"
	echo -e "\t\t ${0} <process name>"
}


[ ${#} -ne 1 ] && printUsage && exit 1
PROC=${1}
RANGE=$(sinfo | grep small| awk ' { print $6 } '| sed  -e 's/hpc\[//g' -e 's/\]//g')
START=$(echo ${RANGE} | awk ' BEGIN { FS="-" } { print $1 }')
END=$(echo ${RANGE} | awk ' BEGIN { FS="-" } { print $2 }')
#for i in $(seq ${START} ${END}) 
for i in $(seq 1 6) 
do
	if [ ${i} -le 9 ]
		then
			HOST="hpc0${i}"
		else
			HOST="hpc${i}"
		fi
	echo "${HOST}: "
	ssh ${HOST} "pgrep -l ${PROC}"
done
exit 0
