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

`chroot /mnt/gentoo grep -v rootfs /proc/mounts > /etc/mtab`

`chroot /mnt/gentoo grub-install --no-floppy /dev/sda`

puts 'Grub is installed'

puts 'Finished'

