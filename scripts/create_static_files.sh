echo 
echo '############################################'
echo '    Making fstab, make.conf, and net.eth0   '
echo '############################################'
echo
echo '/dev/sda1		/boot	ext2	noauto,noatime	1 2' >/mnt/gentoo/etc/fstab
echo '/dev/sda3		/	ext3	noatime		0 1' >>/mnt/gentoo/etc/fstab
echo '10.10.10.1:/usr/portage	/usr/portage	nfs	defaults	0 0' >>/mnt/gentoo/etc/fstab
echo 'proc		/proc	proc	defaults	0 0' >>/mnt/gentoo/etc/fstab
echo 'shm		/dev/shm	tmpfs	nodev,nosuid,noexec	0 0' >>/mnt/gentoo/etc/fstab
echo '#/dev/cdrom             /mnt/cdrom      auto            noauto,ro       0 0' >>/mnt/gentoo/etc/fstab
echo "/dev/sda2       none       swap    sw         0 0" >>/mnt/gentoo/etc/fstab


# Generate /etc/conf.d/net.eth0

echo "config_eth0=( \"dhcp\" )" >> /mnt/gentoo/etc/conf.d/net
chroot /mnt/gentoo ln -s /etc/init.d/net.lo /etc/init.d/net.eth0
chroot /mnt/gentoo /sbin/rc-update add net.eth0 default

# Generate /etc/make.conf ###

echo 'CHOST="i686-pc-linux-gnu"' > /mnt/gentoo/etc/make.conf
echo 'CFLAGS="-march=prescott -O2 -pipe -fomit-frame-pointer"' >> /mnt/gentoo/etc/make.conf
echo 'CXXFLAGS="${CFLAGS}"' >> /mnt/gentoo/etc/make.conf
echo '' >> /mnt/gentoo/etc/make.conf
echo 'MAKEOPTS="-j3"' >> /mnt/getnoo/etc/make.conf
echo '' >> /mnt/gentoo/etc/make.conf
echo 'USE="-* 3dnow gpm symlink mmx ncurses pam sse sse2 tcpd fortran"' >> /mnt/gentoo/etc/make.conf
echo '' >> /mnt/gentoo/etc/make.conf

echo 'done.'
sleep 1

