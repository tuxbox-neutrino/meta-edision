
# eMMC has 8 GB in total, but one image gets only 2 GB of that (Partitioned eMMC)
FLASHSIZE = "2048"

BRAND_OEM = "edision"
MACHINE_BRAND = "Edision"
MACHINE_NAME = "${MACHINE}"

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

DISTRO_FEATURES_append += "bluez5 pulseaudio"

PACKAGECONFIG_GL_pn-qtbase = "gles2 eglfs linuxfb"
PACKAGECONFIG_FB_pn-qtbase = " "

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

##preferred providers
PREFERRED_PROVIDER_virtual/kernel = "linux-edision"
PREFERRED_PROVIDER_virtual/neutrino = "neutrino-mp"
PREFFERED_PROVIDER_virtual/libstb-hal = "libstb-hal"
PREFFERED_PROVIDER_virtual/dvb-driver = "edision-dvb-modules-${MACHINE}"
PREFFERED_PROVIDER_virtual/screengrabber = "grab"
PREFERRED_PROVIDER_virtual/egl ?= "edision-libv3d"
PREFERRED_PROVIDER_virtual/libgles2 ?= "edision-libv3d"

PREFERRED_VERSION_linux-libc-headers = "5.9"

