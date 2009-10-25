#!/usr/bin/ruby
require 'fileutils'
# Jacob Atkins
# Univeristy of Virginia's College at Wise
#
# jta4j@mcs.uvawise.edu

puts 'Installing the required base packages'

`chroot /mnt/gentoo emerge syslog-ng vixie-cron nfs-utils portmap dhcp`

puts 'Done installing the tools'

puts 'Updaing the world'

`chroot /mnt/gentoo emerge -nDu world`

puts 'Done updaing'

puts 'Installing OpenMPI, TORQUE, vim, and ruby'

`chroot /mnt/gentoo emerge openmpi torque vim ruby`

puts 'Finished installing clustering tools'

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




