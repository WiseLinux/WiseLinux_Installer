#!/usr/bin/ruby
require "yaml"

# This script will setup the network and partion/format the harddrive
# Jacob Atkins
# Univerisity of Virginia's College at Wise
#
# jta4j@mcs.uvawise.edu

CONFIG = YAML::load(File.read('../includes/config.yml'))

puts 'Configuring interface eth0'

file = File.open('/etc/resolv.conf', 'w')

file.puts "search #{CONFIG['setup']['dns']['domain']}"
file.puts "nameserver #{CONFIG['setup']['dns']['nameserver1']}" 
file.puts "nameserver #{CONFIG['setup']['dns']['nameserver2']}"

file.close

puts 'Finished configuring eth0'

puts "Making partitions on #{CONFIG['setup']['harddrive']['harddrive']}"

`sfdisk -q /dev/#{CONFIG['setup']['harddrive']['harddrive']} < ../includes/#{CONFIG['setup']['harddrive']['harddrive_map_file']}"`

puts 'Finished making partitions'

puts 'Formating the newly created partitions'
puts '/dev/sda1 will be ext2'
puts '/dev/sda3 will be ext3'

`mkfs.ext2 /dev/sda1`
`mkfs.ext3 /dev/sda3`

puts 'Finished formating'

puts 'Mounting /dev/sda3 to /mnt/gentoo'
puts 'And mounting /dev/sda1 to /mnt/gentoo/boot'

`mount /dev/sda3 /mnt/gentoo`
Dir.mkdir('/mnt/gentoo/boot')
`mount /dev/sda1 /mnt/gentoo/boot`

puts 'Finished mounting'

puts 'Creating and enabling swap on /dev/sda2'

`mkswap /dev/sda2`
`swapon /dev/sda2`

puts 'Finished'

