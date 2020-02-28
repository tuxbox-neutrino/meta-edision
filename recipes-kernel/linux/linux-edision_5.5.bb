DESCRIPTION = "Linux kernel for ${MACHINE}"
SECTION = "kernel"
LICENSE = "GPLv2"

KERNEL_RELEASE = "5.5"

inherit kernel machine_kernel_pr

MACHINE_KERNEL_PR_append = ".3"

PROVIDES  = "virtual/kernel"
RPROVIDES_${PN} = "virtual/kernel"

SRC_URI[md5sum] = "ac640fefefe3916fc729ddc493e3db3f"
SRC_URI[sha256sum] = "c52dfb9d9e9768bec6648230d225ac11d16c9a64e7c07a4611b43df80a048310"

LIC_FILES_CHKSUM = "file://${WORKDIR}/linux-brcmstb-${PV}/COPYING;md5=bbea815ee2795b2f4230826c0c6b8814"

DEPENDS += "flex-native bison-native openssl-native coreutils-native"

# By default, kernel.bbclass modifies package names to allow multiple kernels
# to be installed in parallel. We revert this change and rprovide the versioned
# package names instead, to allow only one kernel to be installed.
PKG_${KERNEL_PACKAGE_NAME}-base = "kernel-base"
PKG_${KERNEL_PACKAGE_NAME}-image = "kernel-image"
RPROVIDES_${KERNEL_PACKAGE_NAME}-base = "kernel-${KERNEL_VERSION}"
RPROVIDES_${KERNEL_PACKAGE_NAME}-image = "kernel-image-${KERNEL_VERSION}"

SRC_URI += "http://source.mynonpublic.com/edision/linux-edision-${PV}.tar.gz \
	file://defconfig \
	"

SRC_URI_append = " \
	file://findkerneldevice.sh \
	"

S = "${WORKDIR}/linux-brcmstb-${PV}"

export OS = "Linux"
KERNEL_OBJECT_SUFFIX = "ko"

KERNEL_OUTPUT_arm = "arch/${ARCH}/boot/${KERNEL_IMAGETYPE}"
KERNEL_IMAGETYPE_arm = "zImage"
KERNEL_IMAGEDEST_arm = "tmp"

FILES_${KERNEL_PACKAGE_NAME}-image_arm = "/${KERNEL_IMAGEDEST}/${KERNEL_IMAGETYPE} /${KERNEL_IMAGEDEST}/findkerneldevice.sh"

kernel_do_install_append_arm() {
        install -d ${D}/${KERNEL_IMAGEDEST}
        install -m 0755 ${KERNEL_OUTPUT} ${D}/${KERNEL_IMAGEDEST}
	install -m 0755 ${WORKDIR}/findkerneldevice.sh ${D}/${KERNEL_IMAGEDEST}
}

pkg_postinst_kernel-image_arm() {
	if [ "x$D" == "x" ]; then
		if [ -f /${KERNEL_IMAGEDEST}/${KERNEL_IMAGETYPE} ] ; then
			/${KERNEL_IMAGEDEST}/findkerneldevice.sh
			dd if=/${KERNEL_IMAGEDEST}/${KERNEL_IMAGETYPE} of=/dev/kernel
		fi
	fi
    true
}
