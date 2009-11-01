#!/usr/bin/ruby
# This script will setup the network and partion/format the harddrive
# Jacob Atkins
# Univerisity of Virginia's College at Wise
#
# jta4j@mcs.uvawise.edu

require 'yaml'

CONFIG = YAML::load(File.read('includes/config.yml'))

puts 'Configuring interface eth0'

file = File.open('/etc/resolv.conf', 'w')

file.puts "search #{CONFIG['setup']['dns']['domain']}"
file.puts "nameserver #{CONFIG['setup']['dns']['nameserver1']}" 
file.puts "nameserver #{CONFIG['setup']['dns']['nameserver2']}"

file.close

puts 'Finished configuring eth0'

puts "Making partitions on #{CONFIG['setup']['harddrive']['harddrive']}"

`sfdisk -q /dev/#{CONFIG['setup']['harddrive']['harddrive']} < includes/#{CONFIG['setup']['harddrive']['harddrive_map_file']}`

puts 'Finished making partitions'

puts 'Formating the newly created partitions'
puts "/dev/#{CONFIG['setup']['harddrive']['boot_partition']} will be #{CONFIG['setup']['harddrive']['boot_filesystem']}"
puts "/dev/#{CONFIG['setup']['harddrive']['root_partition']} will be #{CONFIG['setup']['harddrive']['root_filesystem']}"

`mkfs.#{CONFIG['setup']['harddrive']['boot_filesystem']} /dev/#{CONFIG['setup']['harddrive']['boot_partition']}`
`mkfs.#{CONFIG['setup']['harddrive']['root_filesystem']} /dev/#{CONFIG['setup']['harddrive']['root_partition']}`

puts 'Finished formating'

puts "Mounting /dev/#{CONFIG['setup']['harddrive']['root_partition']} to /mnt/gentoo"
puts "And mounting /dev/#{CONFIG['setup']['harddrive']['boot_partition']} to /mnt/gentoo/boot"

`mount /dev/#{CONFIG['setup']['harddrive']['root_partition']} /mnt/gentoo`
Dir.mkdir('/mnt/gentoo/boot')
`mount /dev/#{CONFIG['setup']['harddrive']['boot_partition']} /mnt/gentoo/boot`

puts 'Finished mounting'

puts "Creating and enabling swap on /dev/#{CONFIG['setup']['harddrive']['swap_partition']}"

`mkswap /dev/#{CONFIG['setup']['harddrive']['swap_partition']}`
`swapon /dev/#{CONFIG['setup']['harddrive']['swap_partition']}`

puts 'Finished'

