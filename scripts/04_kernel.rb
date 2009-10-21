#!/usr/bin/ruby
require 'fileutils'
# Jacob Atkins
# Univeristy of Virginia's College at Wise
#
# jta4j@mcs.uvawise.edu

puts 'Downloading vanilla-sources "Linux Kernel" version 2.6.30.5'

`chroot /mnt/gentoo emerge =sys-kernel/vanilla-sources-2.6.30.5`

puts 'vanilla-sources are in place'

puts 'Creating kernel compile script'

FileUtils.cp 'includes/kernel-config', '/mnt/gentoo/usr/src/linux/.config'

file = File.new('/mnt/gentoo/kernel.sh', 'w')

file.puts('#!/bin/bash')
file.puts('cd /usr/src/linux')
file.puts('make -j3 && make modules_install')
file.puts('cp /usr/src/linux/arch/x86/boot/bzImage /boot/kernel-2.6.30.5')
file.puts('cp /usr/src/linux/System.map /boot')
file.puts('cp /usr/src/linux/.config /boot/config-kernel-2.6.30.5')
file.close

puts 'Kernel script is in place'

puts 'Building the kernel'

FileUtils.chmod 0755, '/mnt/gentoo/kernel.sh'

`chroot /mnt/gentoo ./kernel.sh`

FileUtils.rm_rf '/mnt/gentoo/kernel.sh'

puts 'Kernel built'

puts 'Finished'

