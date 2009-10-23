#!/usr/bin/ruby
require 'fileutils'
# Jacob Atkins
# Univeristy of Virginia's College at Wise
#
# jta4j@mcs.uvawise.edu

puts 'Copying over the fstab to /mnt/gentoo/etc/fstab'

FileUtils.cp 'includes/fstab', '/mnt/gentoo/etc/fstab'

puts 'fstab is in place'

puts 'Copying over make.conf to /mnt/gentoo/etc/make.conf'

FileUtils.cp 'includes/make.conf', '/mnt/gentoo/etc/make.conf'

puts 'make.conf is in place'

puts 'Copying /etc/resolv.conf to /mnt/gentoo/etc/resolv.conf'

FileUtils.cp '/etc/resolv.conf', '/mnt/gentoo/etc/resolv.conf'

puts 'resolv.conf is in place'

puts 'adding eth0 to configuration'

file = File.open('/mnt/gentoo/etc/conf.d/net', 'a')

file.puts('config_eth0=( "dhcp" )')

file.close

puts 'Adding eth0 to boot tasks'

`chroot /mnt/gentoo /sbin/rc-update add net.eth0 default`

puts 'Adding sshd to boot tasks'

`chroot /mnt/gentoo /sbin/rc-update add sshd default`

puts 'Setting root password'

`chroot /mnt/gentoo echo root:foobar | chpasswd`

puts 'Root password set'

puts 'Finished'

