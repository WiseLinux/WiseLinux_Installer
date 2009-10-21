#!/bin/bash
#
# This script will setup the kernel.
# Jacob Atkins
# Univeristy of Virginia's College at Wise
#
# jta4j@mcs.uvawise.edu

# Change this password when you start using these scripts

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

cp /root/includes/config /mnt/gentoo/usr/src/linux/.config
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
	
