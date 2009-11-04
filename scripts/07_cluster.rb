#!/usr/bin/ruby
# Jacob Atkins
# Univeristy of Virginia's College at Wise
#
# jta4j@mcs.uvawise.edu

require 'fileutils'
require 'yaml'

CONFIG = YAML::load(File.read('/root/includes/config.yml'))

puts 'Installing OpenMPI, TORQUE, vim, and ruby'

`chroot /mnt/gentoo emerge openmpi torque vim ruby`

puts 'Finished installing clustering tools'

puts 'Configuring TORQUE'

`chroot /mnt/gentoo emerge --config torque`
`chroot /mnt/gentoo rc-update add pbs_mom default`

pbs_config = File.open('/mnt/gentoo/var/spool/torque/mom_priv/config', 'w')

pbs_config.puts("$pbsserver #{CONFIG['cluster']['torque_server']}")
pbs_config.puts("$logevent 255")

pbs_config.close

puts 'TORQUE is configured'


