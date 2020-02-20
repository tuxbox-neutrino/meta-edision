#!/bin/sh
echo "starting firstboot script"
if ! gdisk -l /dev/mmcblk1 | grep "Found valid GPT with protective MBR"; then
	(
        	echo r # Enter repair options
        	echo d # Create GPT backup
        	echo w # Write changes
        	echo y # confirm changes
	) | gdisk /dev/mmcblk1
fi

rootdevice=$(sed -e 's/^.*root=//' -e 's/ .*$//' < /proc/cmdline)

if [ $rootdevice = /dev/mmcblk1p3 ]; then
        for DEV in /dev/mmcblk1p[3,5,7,9];do
                if blkid $DEV | grep 'ext4' &> /dev/null;then
                        echo "$DEV already present"
                else
                        mkfs.ext4 $DEV
                fi
		echo "Resizing linuxrootfs partition"
		resize2fs "$DEV"
	done
fi

echo "first boot script work done"
#job done, remove it from systemd services
systemctl disable firstboot.service
echo "firstboot script disabled"

[ -f /usr/bin/etckeeper ] && /etc/etckeeper/update_etc.sh

