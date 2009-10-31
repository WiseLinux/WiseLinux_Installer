#!/usr/bin/ruby
require 'fileutils'
require 'yaml'

# Jacob Atkins
# Univeristy of Virginia's College at Wise
#
# jta4j@mcs.uvawise.edu

CONFIG = YAML::load(File.read('/root/includes/config.yml'))

puts 'Copying the stage3 file over'

Dir.chdir('/mnt/gentoo')

FileUtils.cp "/root/stages/#{CONFIG['stage']['stage3_tarbal']}", './'

puts 'Done copying'

puts 'Extracting the stage3'

`tar xjpf ./stage3*`

puts 'Finished extracting'

puts 'Making directory for portage mount'
puts 'And mounting portage'

Dir.mkdir('/mnt/gentoo/usr/portage')

`mount -t nfs #{CONFIG['stage']['portage_server']}:#{CONFIG['stage']['portage_share_name']} /mnt/gentoo/usr/portage`

puts 'Finished mounting portage'

puts 'Mounting /dev and /proc'

`mount -t proc proc /mnt/gentoo/proc`
`mount -o bind /dev /mnt/gentoo/dev`

puts 'Finished mounting /dev and /proc'

puts 'Finished'

