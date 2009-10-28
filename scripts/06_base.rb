#!/usr/bin/ruby
require 'fileutils'
# Jacob Atkins
# Univeristy of Virginia's College at Wise
#
# jta4j@mcs.uvawise.edu

puts 'Installing the required base packages'

`chroot /mnt/gentoo emerge syslog-ng vixie-cron nfs-utils portmap dhcp ntp`

puts 'Done installing the tools'

puts 'Adding tools to rc'

`chroot /mnt/gentoo rc-update add syslog-ng default`
`chroot /mnt/gentoo rc-update add vixie-cron default`
`chroot /mnt/gentoo rc-update add ntp-client default`


puts 'Updaing the world'

`chroot /mnt/gentoo emerge -nDu world`

puts 'Done updaing'

puts 'Finished'

