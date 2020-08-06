
# eMMC has 8 GB in total, but one image gets only 2 GB of that (Partitioned eMMC)
FLASHSIZE = "2048"

BRAND_OEM = "edision"
MACHINE_BRAND = "Edision"
MACHINE_NAME = "${MACHINE}"
IMAGE_LINK = "${IMAGENAME}-${MACHINE}"
MTD_ROOTFS = "mmcblk1p3"
MTD_KERNEL = "mmcblk1p2"
KERNEL_FILE = "kernel.bin"
KERNEL_OUTPUT = "${KERNEL_IMAGETYPE}"
KERNEL_CONSOLE = "ttyS0,115200n8"
ROOTFS_FILE = "rootfs.tar.bz2"
IMAGEDIR = "${MACHINE}"
IMAGE_CLASSES += "osmio4k-emmcimg_multiboot"
IMAGE_FSTYPES ?= "osmio-emmc"
IMAGE_OVERHEAD_FACTOR = "1.0"


PACKAGECONFIG_GL_pn-qtbase = "gles2 eglfs linuxfb"
PACKAGECONFIG_FB_pn-qtbase = " "

PREFERRED_VERSION_linux-edision = "5.5.16"

MACHINE_FEATURES_BACKFILL_CONSIDERED = "rtc"


MACHINE_ESSENTIAL_EXTRA_RDEPENDS += "\
    edision-dvb-modules-${MACHINE} \
"    

BOOTLOGO_FILENAME = "splash.bin"

# arm
DEFAULTTUNE = "armv7vehf-neon-vfpv4"
KERNEL_IMAGETYPE = "zImage"

## arm64
#DEFAULTTUNE = "aarch64"
#KERNEL_IMAGETYPE = "Image.gz"

require conf/machine/include/arm/arch-arm64.inc


