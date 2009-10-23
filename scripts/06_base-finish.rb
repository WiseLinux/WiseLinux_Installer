#!/usr/bin/ruby
require 'fileutils'
# Jacob Atkins
# Univeristy of Virginia's College at Wise
#
# jta4j@mcs.uvawise.edu

puts 'Installing syslog-ng, vixie-cron, nfs-utils, and portmap'

`chroot /mnt/gentoo emerge syslog-ng vixie-cron nfs-utils portmap`

puts 'Done installing the tools'

puts 'Removing stage3 file'

FileUtils.rm_f /mnt/gentoo/stage*




