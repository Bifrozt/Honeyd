#!/bin/bash
#
# by Fabian Bieker <fabian.bieker@web.de>
# modified by DataSoft Corporation
#
# 0.0.2: using absolute paths (by Bifrozt)
#
. /usr/share/honeyd/scripts/misc/base.sh

SRCIP=$1
SRCPORT=$2
DSTIP=$3
DSTPORT=$4

STRINGSFILE="/usr/share/honeyd/scripts/strings/fingerd.strings"
VERSION=`perl -nle '/FINGERD_VERSION (.*)/ and print $1' < $STRINGSFILE`

SERVICE="finger"
HOST="serv"

my_start

read name

# remove control-characters
name=`echo $name | sed s/[[:cntrl:]]//g`

echo "$name" >> $LOG

if [ "$name" == "root" ]; then
	cat << _eof_
$VERSION at $HOST.$DOMAIN !

 $DATE  up 25 days, 12:51, 1 users,  load average: 0.15, 0.11, 0.09

 Login: root                             Name: root
 Directory: /root                        Shell: /bin/bash
 On since Fri Jan 17 20:30 (CET) on pts/0, idle 3 days 14:07
 New mail received Tue Feb 13 15:06 2003 (CET)
      Unread since Wed Jan 22 16:08 2002 (CET)
 No Plan.
_eof_
	my_stop
fi

if [ -z "$name" ]; then
	cat << _eof_
$VERSION at $HOST.$DOMAIN !

 $DATE  up 67 days, 14:57,  2 users,  load average: 0.22, 0.09, 0.2

Login      Name                  Tty      Idle  Login Time   Where
root       root                  pts/0    2     Thu 10:08 pc2.$DOMAIN 
root       root                  pts/1    -     Thu 10:22 pc2.$DOMAIN
_eof_
	my_stop
fi

cat << _eof_
$VERSION at $HOST.$DOMAIN !

 $DATE  up 67 days, 15:07,  2 users,  load average: 0.17, 0.19, 0.8:

finger: $name: no such user.
_eof_
my_stop
