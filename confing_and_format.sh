#!/bin/bash
#
# This script will setup the network and partion/format the harddrive.
# Jacob Atkins
# Univeristy of Virginia's College at Wise
#
# jta4j@mcs.uvawise.edu

echo
echo '############################################'
echo '           Configuring interface...'
echo '############################################'
echo

echo 'search mcs.uvawise.edu' > /etc/resolv.conf
echo 'nameserver 10.10.10.1' >> /etc/recolv.conf
echo 'nameserver 143.60.60.20' >> /etc/resolv.conf
echo 'nameserver 143.60.60.22' >> /etc/resolv.conf

sleep 1

		### Creating partitions ###
echo
echo '############################################'
echo '             Creating partitions...'
echo '############################################'
echo
sfdisk /dev/sda < /root/sda.part
echo 'done.'
sleep 1

			### Mounting ###
echo
echo '############################################'
echo '     Creating filesystems && mount now...'
echo '############################################'
echo

echo
echo 'Which filesystem will be in ROOT? choose one in a list below:
###########################################
mkfs.ext2 /dev/sda1
mkfs.ext3 /dev/sda3
mount /dev/sda3 /mnt/gentoo
mkdir /mnt/gentoo/boot
mkswap /dev/sda2
swapon /dev/sda2
echo 'done.'
sleep 1

