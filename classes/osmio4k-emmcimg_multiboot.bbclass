inherit image_types image_version

IMAGE_TYPEDEP_osmio-emmc = "ext4 tar.bz2"

BOOTDD_VOLUME_ID = "boot"
do_image_osmio_emmc[depends] = " \
	parted-native:do_populate_sysroot \
	dosfstools-native:do_populate_sysroot \
	mtools-native:do_populate_sysroot \
	zip-native:do_populate_sysroot \
	virtual/kernel:do_populate_sysroot \
"

EMMC_IMAGE = "${DEPLOY_DIR_IMAGE}/emmc.img"
EMMC_IMAGE_SIZE = "7634944"

IMAGE_ROOTFS_ALIGNMENT = "1024"
BOOT_PARTITION_SIZE = "3072"
KERNEL_PARTITION_SIZE = "8192"
ROOTFS_PARTITION_SIZE = "1767400"
#IMAGE_ROOTFS_SIZE ?= "750000"

KERNEL1_PARTITION_OFFSET = "$(expr ${IMAGE_ROOTFS_ALIGNMENT} + ${BOOT_PARTITION_SIZE})"
ROOTFS1_PARTITION_OFFSET = "$(expr ${KERNEL1_PARTITION_OFFSET} + ${KERNEL_PARTITION_SIZE})"
KERNEL2_PARTITION_OFFSET = "$(expr ${ROOTFS1_PARTITION_OFFSET} + ${ROOTFS_PARTITION_SIZE})"
ROOTFS2_PARTITION_OFFSET = "$(expr ${KERNEL2_PARTITION_OFFSET} + ${KERNEL_PARTITION_SIZE})"
KERNEL3_PARTITION_OFFSET = "$(expr ${ROOTFS2_PARTITION_OFFSET} + ${ROOTFS_PARTITION_SIZE})"
ROOTFS3_PARTITION_OFFSET = "$(expr ${KERNEL3_PARTITION_OFFSET} + ${KERNEL_PARTITION_SIZE})"
KERNEL4_PARTITION_OFFSET = "$(expr ${ROOTFS3_PARTITION_OFFSET} + ${ROOTFS_PARTITION_SIZE})"
ROOTFS4_PARTITION_OFFSET = "$(expr ${KERNEL4_PARTITION_OFFSET} + ${KERNEL_PARTITION_SIZE})"
SWAP_PARTITION_OFFSET = "$(expr ${ROOTFS4_PARTITION_OFFSET} + ${ROOTFS_PARTITION_SIZE})"

IMAGE_CMD_osmio-emmc () {
    dd if=/dev/zero of=${EMMC_IMAGE} bs=1 count=0 seek=$(expr ${EMMC_IMAGE_SIZE} \* 1024)
    parted -s ${EMMC_IMAGE} mklabel gpt
    parted -s ${EMMC_IMAGE} unit KiB mkpart boot fat16 ${IMAGE_ROOTFS_ALIGNMENT} $(expr ${IMAGE_ROOTFS_ALIGNMENT} + ${BOOT_PARTITION_SIZE})
    parted -s ${EMMC_IMAGE} set 1 boot on
    parted -s ${EMMC_IMAGE} unit KiB mkpart kernel1 ${KERNEL1_PARTITION_OFFSET} $(expr ${KERNEL1_PARTITION_OFFSET} + ${KERNEL_PARTITION_SIZE})
    parted -s ${EMMC_IMAGE} unit KiB mkpart rootfs1 ext4 ${ROOTFS1_PARTITION_OFFSET} $(expr ${ROOTFS1_PARTITION_OFFSET} + ${ROOTFS_PARTITION_SIZE})
    parted -s ${EMMC_IMAGE} unit KiB mkpart kernel2 ${KERNEL2_PARTITION_OFFSET} $(expr ${KERNEL2_PARTITION_OFFSET} + ${KERNEL_PARTITION_SIZE})
    parted -s ${EMMC_IMAGE} unit KiB mkpart rootfs2 ext4 ${ROOTFS2_PARTITION_OFFSET} $(expr ${ROOTFS2_PARTITION_OFFSET} + ${ROOTFS_PARTITION_SIZE})
    parted -s ${EMMC_IMAGE} unit KiB mkpart kernel3 ${KERNEL3_PARTITION_OFFSET} $(expr ${KERNEL3_PARTITION_OFFSET} + ${KERNEL_PARTITION_SIZE})
    parted -s ${EMMC_IMAGE} unit KiB mkpart rootfs3 ext4 ${ROOTFS3_PARTITION_OFFSET} $(expr ${ROOTFS3_PARTITION_OFFSET} + ${ROOTFS_PARTITION_SIZE})
    parted -s ${EMMC_IMAGE} unit KiB mkpart kernel4 ${KERNEL4_PARTITION_OFFSET} $(expr ${KERNEL4_PARTITION_OFFSET} + ${KERNEL_PARTITION_SIZE})
    parted -s ${EMMC_IMAGE} unit KiB mkpart rootfs4 ext4 ${ROOTFS4_PARTITION_OFFSET} $(expr ${ROOTFS4_PARTITION_OFFSET} + ${ROOTFS_PARTITION_SIZE})
    parted -s ${EMMC_IMAGE} unit KiB mkpart swap linux-swap ${SWAP_PARTITION_OFFSET} 100%
    dd if=/dev/zero of=${WORKDIR}/boot.img bs=1024 count=${BOOT_PARTITION_SIZE}
    mkfs.msdos -n "${BOOTDD_VOLUME_ID}" -S 512 ${WORKDIR}/boot.img
    echo "setenv STARTUP \"boot emmcflash0.kernel1 'root=/dev/mmcblk1p3 rootfstype=ext4 rootwait'\"" > ${WORKDIR}/STARTUP
    echo "setenv STARTUP \"boot emmcflash0.kernel1 'root=/dev/mmcblk1p3 rootfstype=ext4 rootwait'\"" > ${WORKDIR}/STARTUP_1
    echo "setenv STARTUP \"boot emmcflash0.kernel2 'root=/dev/mmcblk1p5 rootfstype=ext4 rootwait'\"" > ${WORKDIR}/STARTUP_2
    echo "setenv STARTUP \"boot emmcflash0.kernel3 'root=/dev/mmcblk1p7 rootfstype=ext4 rootwait'\"" > ${WORKDIR}/STARTUP_3
    echo "setenv STARTUP \"boot emmcflash0.kernel4 'root=/dev/mmcblk1p9 rootfstype=ext4 rootwait'\"" > ${WORKDIR}/STARTUP_4
    mcopy -i ${WORKDIR}/boot.img -v ${WORKDIR}/STARTUP ::
    mcopy -i ${WORKDIR}/boot.img -v ${WORKDIR}/STARTUP_1 ::
    mcopy -i ${WORKDIR}/boot.img -v ${WORKDIR}/STARTUP_2 ::
    mcopy -i ${WORKDIR}/boot.img -v ${WORKDIR}/STARTUP_3 ::
    mcopy -i ${WORKDIR}/boot.img -v ${WORKDIR}/STARTUP_4 ::
    dd conv=notrunc if=${WORKDIR}/boot.img of=${EMMC_IMAGE} seek=1 bs=$(expr ${IMAGE_ROOTFS_ALIGNMENT} \* 1024)
    dd conv=notrunc if=${DEPLOY_DIR_IMAGE}/${KERNEL_IMAGETYPE} of=${EMMC_IMAGE} seek=1 bs=$(expr ${IMAGE_ROOTFS_ALIGNMENT} \* 1024 + ${BOOT_PARTITION_SIZE} \* 1024)
    dd if=${IMGDEPLOYDIR}/${IMAGE_BASENAME}-${MACHINE}.ext4 of=${EMMC_IMAGE} seek=1 bs=$(expr ${IMAGE_ROOTFS_ALIGNMENT} \* 1024 + ${BOOT_PARTITION_SIZE} \* 1024 + ${KERNEL_PARTITION_SIZE} \* 1024)
}




image_packaging() {
	IMAGE_FILE_NAME_PREFIX=`get_filename_prefix`
	IMAGE_FILE_NAME_LATEST_PREFIX=`get_filename_latest_prefix`

	cd ${DEPLOY_DIR_IMAGE}
	mkdir -p ${IMAGEDIR}

	cp ${IMGDEPLOYDIR}/${IMAGE_NAME}.rootfs.tar.bz2 ${IMAGEDIR}/rootfs.tar.bz2
	cp ${KERNEL_IMAGETYPE} ${IMAGEDIR}/${KERNEL_FILE}
	echo ${IMAGE_NAME} > ${IMAGEDIR}/imageversion
	zip ${IMAGE_FILE_NAME_PREFIX}_ofgwrite.zip ${IMAGEDIR}/*
	ln -sf ${IMAGE_FILE_NAME_PREFIX}_ofgwrite.zip ${IMAGE_FILE_NAME_LATEST_PREFIX}_ofgwrite.zip
	rm -Rf ${IMAGEDIR}

	cd ${DEPLOY_DIR_IMAGE}
	mkdir -p ${IMAGEDIR}
	cp -f ${DEPLOY_DIR_IMAGE}/${BOOTLOGO_FILENAME} ${IMAGEDIR}/${BOOTLOGO_FILENAME}
	cp -f ${DEPLOY_DIR_IMAGE}/emmc.img ${IMAGEDIR}/emmc.img
	echo ${IMAGE_NAME} > ${IMAGEDIR}/imageversion
	echo ${IMAGE_NAME} > ${DEPLOY_DIR_IMAGE}/imageversion
	echo "rename this file to 'force' to force an update without confirmation" > ${IMAGEDIR}/noforce
	zip ${IMAGE_FILE_NAME_PREFIX}_usb.zip ${IMAGEDIR}/*
	ln -sf ${IMAGE_FILE_NAME_PREFIX}_usb.zip ${IMAGE_FILE_NAME_LATEST_PREFIX}_usb.zip
    
	for f in  "tar ext4 manifest json img" ; do
		rm -f ${DEPLOY_DIR_IMAGE}/*.$f
	done
	rm -Rf ${IMAGEDIR}
}

IMAGE_POSTPROCESS_COMMAND += "image_packaging; "

