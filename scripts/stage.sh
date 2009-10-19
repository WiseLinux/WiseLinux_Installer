#!/bin/bash
#
# This script will setup the network and partion/format the harddrive.
# Jacob Atkins
# Univeristy of Virginia's College at Wise
#
# jta4j@mcs.uvawise.edu

#These scripts are running from a nfs file system so I can place the stage in the /root
#dir and have the system copy it over.

echo
echo '############################################'
echo '      copying the stage3 file'
echo '############################################'
echo
cd /mnt/gentoo
cp /root/stages/stage3-i686-20091013.tar.bz2 ./ 

echo 'done.'
sleep 1
		
			### Extracting the stage ###
echo
echo '############################################'
echo '          Extracting the stage3 file        '
echo '############################################'
echo
cd /mnt/gentoo && tar xjpf ./stage3*

#Have to make the portage dir sence we are using an nfs share of portage
mkdir /mnt/gentoo/usr/portage

echo 'done.'
sleep 1