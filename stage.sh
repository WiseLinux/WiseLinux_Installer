#!/bin/bash
#
# This script will setup the network and partion/format the harddrive.
# Jacob Atkins
# Univeristy of Virginia's College at Wise
#
# jta4j@mcs.uvawise.edu

echo
echo '############################################'
echo '      copying portage and stage3...'
echo '############################################'
echo
cd /mnt/gentoo
cp /root/stage3-i686-20091013.tar.bz2 ./ 

echo 'done.'
sleep 1
		
			### Extracting Stage and Portage ###
echo
echo '############################################'
echo '                 Extracting...'
echo '############################################'
echo
cd /mnt/gentoo && tar xjpf ./stage3*
mkdir /mnt/gentoo/usr/portage
echo 'done.'
sleep 1
