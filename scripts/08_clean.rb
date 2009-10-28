#!/usr/bin/ruby
require 'fileutils'
# Jacob Atkins
# Univeristy of Virginia's College at Wise
#
# jta4j@mcs.uvawise.edu

puts 'Removing stage3 file'

FileUtils.rm_f '/mnt/gentoo/stage*'

puts 'Unmounting file systems'

`umount /mnt/gentoo/dev`
`umount /mnt/gentoo/proc`
`umount /mnt/gentoo/usr/portage`
`umount /mnt/gentoo/boot`
`umount /mnt/gentoo`

puts 'Rebooting'

`reboot`