#!/usr/bin/ruby
# Jacob Atkins
# Univeristy of Virginia's College at Wise
#
# jta4j@mcs.uvawise.edu

require 'fileutils'
require 'yaml'

CONFIG = YAML::load(File.read('/root/includes/config.yml'))

puts 'Building grub.conf'

file = File.open("/mnt/gentoo/boot/grub/grub.conf", 'w')

file.puts 'default 0'
file.puts 'timeout 5'
file.puts ''
file.puts 'title Wise Linux'
file.puts 'root (hd0,0)'
if CONFIG['kernel']['build'] == true
  file.puts "kernel /boot/kernel-#{CONFIG['kernel']['version']} root=/dev/#{CONFIG['setup']['harddrive']['root_partition']}"
else
  file.puts "kernel /boot/#{CONFIG['kernel']['kernel_image']} root=/dev/#{CONFIG['setup']['harddrive']['root_partition']}"
end
file.puts ''

file.close

puts 'Done building grub.conf'

puts 'Installing grub to the MBR'

grub = File.new('/mnt/gentoo/grub.sh', 'w')

grub.puts('#!/bin/bash')
grub.puts('')
grub.puts('grep -v rootfs /proc/mounts > /etc/mtab')
grub.puts("grub-install -no-floppy /dev/#{CONFIG['setup']['harddrive']['harddrive']}")

grub.close

FileUtils.chmod 0755, '/mnt/gentoo/grub.sh'

`chroot /mnt/gentoo ./grub.sh`

FileUtils.rm_rf '/mnt/gentoo/grub.sh'

puts 'Grub is installed'

puts 'Finished'

