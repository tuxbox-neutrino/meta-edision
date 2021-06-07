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

swap_device=$(blkid -t  PARTLABEL="swap" -o device | head -n1)
[ -z "$swap_device" ] && echo "no swap device found!"
if [ -n "$swap_device" ]; then
	(cat /proc/swaps | grep -q "$swap_device" || swapon "$swap_device") || (mkswap "$swap_device" && swapon "$swap_device")
	grep -q "$swap_device" /etc/fstab || echo "$swap_device none swap defaults 0 0" >> /etc/fstab
fi

box_model=$(grep "^box_model=" /etc/image-version | cut -d'=' -f2)
hwaddr=$(ifconfig eth0 | awk '/HWaddr/ { split($5,v,":"); print v[5] v[6] }')
hname=${box_model}-${hwaddr}
echo "${hname}" > /etc/hostname
hostname ${hname}

echo "first boot script work done"
#job done, remove it from systemd services
systemctl disable firstboot.service
echo "firstboot script disabled"

[ -f /usr/bin/etckeeper ] && /etc/etckeeper/update_etc.sh

