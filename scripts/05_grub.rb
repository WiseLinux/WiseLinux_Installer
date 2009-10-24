#!/usr/bin/ruby
require 'fileutils'
# Jacob Atkins
# Univeristy of Virginia's College at Wise
#
# jta4j@mcs.uvawise.edu

puts 'Building grub.conf'

file = File.open("/mnt/gentoo/boot/grub/grub.conf", 'w')

file.puts 'default 0'
file.puts 'timeout 5'
file.puts ''
file.puts 'title Wise Linux'
file.puts 'root (hd0,0)'
file.puts 'kernel /boot/kernel-2.6.30.5 root=/dev/sda3'
file.puts ''

file.close

puts 'Done building grub.conf'

puts 'Installing grub to the MBR'

grub = File.new('/mnt/gentoo/grub.sh', 'w')

grub.puts('#!/bin/bash')
grub.puts('')
grub.puts('grep -v rootfs /proc/mounts > /etc/mtab')
grub.puts('grub-install -no-floppy /dev/sda')

grub.close

FileUtils.chmod 0755, '/mnt/gentoo/grub.sh'

`chroot /mnt/gentoo ./grub.sh`

FileUtils.rm_rf '/mnt/gentoo/grub.sh'

puts 'Grub is installed'

puts 'Finished'

