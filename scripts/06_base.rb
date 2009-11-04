#!/usr/bin/ruby
# Jacob Atkins
# Univeristy of Virginia's College at Wise
#
# jta4j@mcs.uvawise.edu

require 'fileutils'
require 'yaml'

CONFIG = YAML::load(File.read('/root/includes/config.yml'))

puts 'Installing the required base packages'

`chroot /mnt/gentoo emerge syslog-ng vixie-cron nfs-utils portmap dhcp ntp`

puts 'Done installing the tools'

puts 'Adding tools to rc'

`chroot /mnt/gentoo rc-update add syslog-ng default`
`chroot /mnt/gentoo rc-update add vixie-cron default`
`chroot /mnt/gentoo rc-update add ntp-client default`

if CONFIG['base']['update'] == true
  puts 'Updaing the world'
  `chroot /mnt/gentoo emerge -nDu world`
  puts 'Done world is up to date'
end

puts 'Finished'

