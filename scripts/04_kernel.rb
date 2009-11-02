#!/usr/bin/ruby
# Jacob Atkins
# Univeristy of Virginia's College at Wise
#
# jta4j@mcs.uvawise.edu

require 'fileutils'
require 'yaml'

CONFIG = YAML::load(File.read('/root/includes/config.yml'))

if CONFIG['kernel']['build'] == true
  
  puts "Downloading vanilla-sources \"Linux Kernel\" version #{CONFIG['kernel']['version']}"

  `chroot /mnt/gentoo emerge =sys-kernel/vanilla-sources-#{CONFIG['kernel']['version']}`

  puts 'vanilla-sources are in place'

  puts 'Creating kernel compile script'

  FileUtils.cp "includes/#{CONFIG['kernel']['config_file']}", '/mnt/gentoo/usr/src/linux/.config'

  file = File.new('/mnt/gentoo/kernel.sh', 'w')

  file.puts('#!/bin/bash')
  file.puts('cd /usr/src/linux')
  file.puts("make -j#{CONFIG['kernel']['makeopts']} && make modules_install")
  file.puts("cp /usr/src/linux/arch/x86/boot/bzImage /boot/kernel-#{CONFIG['kernel']['version']}")
  file.close

  puts 'Kernel script is in place'

  puts 'Building the kernel'

  FileUtils.chmod 0755, '/mnt/gentoo/kernel.sh'

  `chroot /mnt/gentoo ./kernel.sh`

  FileUtils.rm_rf '/mnt/gentoo/kernel.sh'

  puts 'Kernel built'
  
else
  puts "Copying kernel image #{CONFIG['kernel']['kernel_image']}"

  `chroot /mnt/gentoo emerge =sys-kernel/vanilla-sources-#{CONFIG['kernel']['version']}`
  FileUtils.cp "kernels/#{CONFIG['kernel']['kernel_image']}", "/mnt/gentoo/boot/#{CONFIG['kernel']['kernel_image']}"
  
  puts "Kernel is in place"
end

puts 'Installing grub boot loader'

`chroot /mnt/gentoo emerge grub`

puts 'grub is installed'

puts 'Finished'

