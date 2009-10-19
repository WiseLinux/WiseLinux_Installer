#!/bin/bash

#		Gentoo Install Script v.1.8.1
#	
#	Written by Valetov "Heretiqu3" Konstantin under GNU GPLv2
#		mailto:666@thetrue.name (english|russian)
#		icq:1286182
#Thanks to:
#	Gentoo - for exellent system!
#	hard0ff - for testing script.
#	Pollux - for helping me with my poor english.
#	Morpheus (YYC) - for some ideas.	
#	bash, vim, kwrite and minimal-cd [-:
# TODO:
# auto generate make.conf
# auto generate grub.conf


### Configure eth-interface ###

echo
echo '############################################'
echo '           Configuring interface...'
echo '############################################'
echo

echo 'search mcs.uvawise.edu' > /etc/resolv.conf
echo 'nameserver 10.10.10.1' >> /etc/recolv.conf
echo 'nameserver 143.60.60.20' >> /etc/resolv.conf
echo 'nameserver 143.60.60.22' >> /etc/resolv.conf

sleep 1

			### Creating partitions ###
echo
echo '############################################'
echo '             Creating partitions...'
echo '############################################'
echo
sfdisk /dev/sda < /root/sda.part
echo 'done.'
sleep 1

			### Mounting ###
echo
echo '############################################'
echo '     Creating filesystems && mount now...'
echo '############################################'
echo

echo
#echo 'Which filesystem will be in ROOT? choose one in a list below:
############################################
mkfs.ext2 /dev/sda1
mkfs.ext3 /dev/sda3
mount /dev/sda3 /mnt/gentoo
mkdir /mnt/gentoo/boot
mount /dev/sda1 /mnt/gentoo/boot
mkswap /dev/sda2
swapon /dev/sda2
echo 'done.'
sleep 1

			### Downloading Stage and Portage ###
echo
echo '############################################'
echo '      copying portage and stage3...'
echo '############################################'
echo
cd /mnt/gentoo
cp /root/stage3-i686-20091013.tar.bz2 ./ 

echo 'done.'
sleep 1
		
			### Extracting Stage and Portage ###
echo
echo '############################################'
echo '                 Extracting...'
echo '############################################'
echo
cd /mnt/gentoo && tar xjpf ./stage3*
mkdir /mnt/gentoo/usr/portage
echo 'done.'
sleep 1

			### Prepare for chrooting ###

echo
echo '############################################'
echo '   Mounting portage, bind, and proc...      '
echo '############################################'
echo
mount -t proc proc /mnt/gentoo/proc
mount -o bind /dev /mnt/gentoo/dev
mount -t nfs 10.10.10.1:/usr/portage /mnt/gentoo/usr/portage
echo 'done.'
sleep 1

			### Edit fstab now ###

echo 
echo '############################################'
echo '               editing fstab...'
echo '############################################'
echo
mv /mnt/gentoo/etc/fstab /mnt/gentoo/etc/fstab.back
echo '/dev/sda1		/boot	ext2	noauto,noatime	1 2' >>/mnt/gentoo/etc/fstab
echo '/dev/sda3		/	ext3	noatime		0 1' >>/mnt/gentoo/etc/fstab
echo '10.10.10.1:/usr/portage	/usr/portage	nfs	defaults	0 0' >>/mnt/gentoo/etc/fstab
echo 'proc		/proc	proc	defaults	0 0' >>/mnt/gentoo/etc/fstab
echo 'shm		/dev/shm	tmpfs	nodev,nosuid,noexec	0 0' >>/mnt/gentoo/etc/fstab
echo '#/dev/cdrom             /mnt/cdrom      auto            noauto,ro       0 0' >>/mnt/gentoo/etc/fstab
echo "/dev/sda2       none       swap    sw         0 0" >>/mnt/gentoo/etc/fstab

echo 'done.'
sleep 1

			### Generate /etc/conf.d/net ###

echo
echo '###########################################'
echo '        generating /etc/conf.d/net'
echo '###########################################'
echo

echo "config_eth0=( \"dhcp\" )" >> /mnt/gentoo/etc/conf.d/net
chroot /mnt/gentoo ln -s /etc/init.d/net.lo /etc/init.d/net.eth0
chroot /mnt/gentoo /sbin/rc-update add net.eth0 default

			### Changing password ###

echo
echo '############################################'
echo '             changing password...'
echo '############################################'
echo
chroot /mnt/gentoo passwd
echo 'done.'
sleep 1


			### Safe flags script start ###

echo 'CHOST="i686-pc-linux-gnu"' >> /mnt/gentoo/etc/make.conf
echo 'CFLAGS="-march=prescott -O2 -pipe -fomit-frame-pointer"' >> /mnt/gentoo/etc/make.conf
echo 'CXXFLAGS="${CFLAGS}"' >> /mnt/gentoo/etc/make.conf
echo '' >> /mnt/gentoo/etc/make.conf
echo 'MAKEOPTS="-j3"' >> /mnt/getnoo/etc/make.conf
echo '' >> /mnt/gentoo/etc/make.conf
echo 'USE="-* 3dnow gpm symlink mmx ncurses pam sse sse2 tcpd fortran"' >> /mnt/gentoo/etc/make.conf
echo '' >> /mnt/gentoo/etc/make.conf

			### Emerging ###

echo
echo '############################################'
echo '    downloading vanilla-sources and grub ...'
echo '############################################'
cp -L /etc/resolv.conf /mnt/gentoo/etc
sleep 2
chroot /mnt/gentoo emerge =sys-kernel/vanilla-sources-2.6.30.5 grub
echo
echo '###########################################'
echo '           building kernel'
echo '###########################################'
echo
			### Making Kernel script ###

cp /root/config /mnt/gentoo/usr/src/linux/.config
echo '#!/bin/bash' > /mnt/gentoo/kernel.sh
echo 'cd /usr/src/linux' >> /mnt/gentoo/kernel.sh
echo 'make -j3 && make modules_install' >> /mnt/gentoo/kernel.sh
echo 'cp /usr/src/linux/arch/x86/boot/bzImage /boot/kernel-2.6.30.5' >> /mnt/gentoo/kernel.sh
echo 'cp /usr/src/linux/System.map /boot' >> /mnt/gentoo/kernel.sh
echo 'cp /usr/src/linux/.config /boot/config-kernel-2.6.30.5' >> /mnt/gentoo/kernel.sh
chmod +x /mnt/gentoo/kernel.sh
chroot /mnt/gentoo ./kernel.sh
rm -f /mnt/gentoo/kernel.sh
echo 'done.'
sleep 1			
			
			### Grub ###
echo
echo '############################################'
echo '              making grub.conf...'
echo '############################################'
echo
#################################################################################################
echo 'default 0' > /mnt/gentoo/boot/grub/grub.conf
echo 'timeout 5' >> /mnt/gentoo/boot/grub/grub.conf
echo '' >> /mnt/gentoo/boot/grub/grub.conf
echo 'title Wise Linux' >> /mnt/gentoo/boot/grub/grub.conf
echo 'root (hd0,0)' >> /mnt/gentoo/boot/grub/grub.conf
echo 'kernel /boot/kerenl-2.6.30.5 root=/dev/sda3' >> /mnt/gentoo/boot/grub/grub.conf
echo '' >> /mnt/gentoo/boot/grub/grub.conf
 
echo 'done.'
sleep 1

echo
echo '############################################'
echo '           install grub to MBR...'
echo '############################################'
echo
echo 'press ENTER'
read
chroot /mnt/gentoo grub
echo 'done.'
sleep 1

			### Emerge tools ###

echo
echo '############################################'
echo '             Emerging tools...'
echo '############################################'
echo
echo 'Would you like to install vixie-cron? [y/n] '
read cronq
while [[ "$cronq" != "y" && "$cronq" != "n" ]]
	do
		echo '[y/n] '
		read cronq
	done
if [ "$cronq" = "y" ]
	then
		cron='vixie-cron'
fi
echo 'Would you like to install syslog-ng? [y/n] '
read loggerq
while [[ "$loggerq" != "y" && "$loggerq" != "n" ]]
	do
		echo '[y/n] '
		read loggerq
	done
if [ "$loggerq" = "y" ]
	then
		logger='syslog-ng'
fi
echo 'Would you like to install gentoolkit, portage-utils, pciutils, iputils? [y/n] '
read utilsq
while [[ "$utilsq" != "y" && "$utilsq" != "n" ]]
	do
		echo '[y/n] '
		read utilsq
	done
if [ "$utilsq" = "y" ]
	then
		utils='gentoolkit portage-utils pciutils slocate iputils'
fi
echo 'Would you like to install dhcpcd? [y/n] '
read dhcpq
while [[ "$dhcpq" != "y" && "$dhcpq" != "n" ]]
	do
		echo '[y/n] '
		read dhcpq
	done
if [ "$dhcpq" = "y" ]
	then
		dhcp=dhcpcd
fi

if [[ "$loggerq" = "n" && "$cronq" = "n" && "$utilsq" = "n" && "$dhcpq" = "n" ]]
	then 
		echo 'Ok, skipped.'
	else
		echo
		echo '############################################'
		echo '           Merging selected tools...'
		echo '############################################'
		echo
		chroot /mnt/gentoo emerge $logger $cron $utils $dhcp
		chroot /mnt/gentoo rc-update -a $logger default 2>/dev/null
		chroot /mnt/gentoo rc-update -a $cron default 2>/dev/null
fi
echo 'done.'
sleep 1

			### Final Part ###
echo
echo '############################################'
echo "        That's all, you can reboot"
echo '############################################'
echo
rm -f /mnt/gentoo/stage* /mnt/gentoo/portage*
echo 'cd / && umount /mnt/gentoo/boot /mnt/gentoo/dev /mnt/gentoo/proc /mnt/gentoo && sync && reboot'
echo 'press ctrl+C if you dont want to do this'
for x in `seq 1 5`
do
	echo -n "$x "
	sleep 1
done
echo
echo 'Executing...'
cd / && umount /mnt/gentoo/boot /mnt/gentoo/dev /mnt/gentoo/proc /mnt/gentoo && sync && reboot
else
	echo 'You can rerun me anytime, just type sh install.sh in konsole'
	echo 'I understand, farewell.'
fi
