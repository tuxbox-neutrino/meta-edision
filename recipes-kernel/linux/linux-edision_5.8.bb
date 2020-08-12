DESCRIPTION = "Linux kernel for ${MACHINE}"
SECTION = "kernel"
LICENSE = "GPLv2"

KERNEL_RELEASE = "5.8.0"

inherit kernel machine_kernel_pr

MACHINE_KERNEL_PR_append = ".1"

PROVIDES  = "virtual/kernel"
RPROVIDES_${PN} = "virtual/kernel"

SRC_URI[kernel.sha256sum] = "e7f75186aa0642114af8f19d99559937300ca27acaf7451b36d4f9b0f85cf1f5"
SRC_URI[kernelpatch.sha256sum] = "6e9055de7beda40257b595b90dd0627decfd84ab0f757e70211d01e5fe661bd8"

LIC_FILES_CHKSUM = "file://${WORKDIR}/linux-${PV}/COPYING;md5=6bc538ed5bd9a7fc9398086aedcd7e46"

DEPENDS += "flex-native bison-native openssl-native coreutils-native gmp-native"

# By default, kernel.bbclass modifies package names to allow multiple kernels
# to be installed in parallel. We revert this change and rprovide the versioned
# package names instead, to allow only one kernel to be installed.
PKG_${KERNEL_PACKAGE_NAME}-base = "kernel-base"
PKG_${KERNEL_PACKAGE_NAME}-image = "kernel-image"
RPROVIDES_${KERNEL_PACKAGE_NAME}-base = "kernel-${KERNEL_VERSION}"
RPROVIDES_${KERNEL_PACKAGE_NAME}-image = "kernel-image-${KERNEL_VERSION}"

SRC_URI = "${KERNELORG_MIRROR}/linux/kernel/v5.x/linux-${PV}.tar.xz;name=kernel \
	https://github.com/edision-open/edision-kernel/releases/download/v${PV}/edision-kernel-${PV}.patch.xz;apply=yes;name=kernelpatch \
	file://defconfig \
	file://findkerneldevice.sh \
	"

S = "${WORKDIR}/linux-${PV}"

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
