#!/usr/bin/ruby
require 'fileutils'
# Jacob Atkins
# Univeristy of Virginia's College at Wise
#
# jta4j@mcs.uvawise.edu

puts 'Installing OpenMPI, TORQUE, vim, and ruby'

`chroot /mnt/gentoo emerge openmpi torque vim ruby`

puts 'Finished installing clustering tools'

puts 'Configuring torque'

`chroot /mnt/gentoo emerge --config torque`
`chroot /mnt/gentoo rc-update add pbs_mom default`

