#!/bin/bash
#
# This script will setup the network and partion/format the harddrive.
# Jacob Atkins
# Univeristy of Virginia's College at Wise
#
# jta4j@mcs.uvawise.edu

# Change this password when you start using these scripts

echo
echo '############################################'
echo '           Setting root password'
echo '############################################'
echo

chroot /mnt/gentoo echo root:foobar | chpasswd

echo 'done.'
sleep 1
