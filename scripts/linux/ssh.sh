#!/bin/bash
#
# $1: srcip, $2: srcport, $3: dstip, $4: dstport, $5: config
#
# modified by Fabian Bieker <fabian.bieker@web.de>
# modified by DataSoft Corporation
# 
# 0.0.2: using absolute paths (by Bifrozt)
#

. /usr/share/honeyd/scripts/misc/base.sh

SRCIP=$1
SRCPORT=$2
DSTIP=$3
DSTPORT=$4

STRINGSFILE="/usr/share/honeyd/scripts/strings/ssh.strings"
VERSION=`perl -nle '/SSH_VERSION (.*)/ and print $1' < $STRINGSFILE`

SERVICE="ssh"
HOST="serv"


my_start

echo -e "$VERSION"

while read name; do
	echo "$name" >> $LOG
	LINE=`echo "$name" | egrep -i "[\n ]"`
	if [ -z "$LINE" ]; then
		echo "Protocol mismatch."
		my_stop	
	else
        echo "$name"
	fi
done
my_stop

