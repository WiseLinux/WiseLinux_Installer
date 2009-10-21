#!/usr/bin/ruby
'require 'fileutils'
# Jacob Atkins
# Univeristy of Virginia's College at Wise
#
# jta4j@mcs.uvawise.edu

puts 'Copying the stage3 file over'

Dir.chdir('/mnt/gentoo')

FileUtils.cp /root/stages/stage3-i686-20091013.tar.bz2 ./

puts 'Done copying'

puts 'Extracting the stage3'

`tar xjpf ./stage3*`

puts 'Finished extracting'

puts 'Making directory for portage mount'
puts 'And mounting portage'

Dir.mkdir('/mnt/gentoo/usr/portage')

`mount -t nfs 10.10.10.1:/usr/portage /mnt/gentoo/usr/portage`

puts 'Finished mounting portage'

puts 'Mounting /dev and /proc'

`mount -t proc proc /mnt/gentoo/proc`
`mount -o bind /dev /mnt/gentoo/dev`

puts 'Finished mounting /dev and /proc'

puts 'Finished'

