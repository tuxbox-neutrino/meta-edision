SUMMARY = "Qualcomm WiFi driver for QCA module 6174"
LICENSE = "BSD & GPLv2"
LIC_FILES_CHKSUM = "file://Android.mk;md5=235cc8d87e0fb1c956be4af0d07074fb"
CAF_MIRROR = "https://www.codeaurora.org/cgit/external/wlan"

inherit module

COMPATIBLE_MACHINE = "osmio4k|osmio4kplus"

SRC_URI = "${CAF_MIRROR}/qcacld-2.0/snapshot/qcacld-2.0-${PV}.tar.gz \
    file://qcacld-2.0-support.patch \
"

S = "${WORKDIR}/qcacld-2.0-${PV}"

do_install() {
    install -d ${D}${nonarch_base_libdir}/modules/${KERNEL_VERSION}/extra
    install -m 0644 ${S}/wlan.ko ${D}${nonarch_base_libdir}/modules/${KERNEL_VERSION}/extra
}

python do_package_prepend() {
    d.prependVar('PKGV', '-')
    d.prependVar('PKGV', d.getVar("KERNEL_VERSION", True).split("-")[0])
}

SRC_URI[md5sum] = "a8773ee40f603c33c604a38aa26bcdc5"
SRC_URI[sha256sum] = "2f675a3efc879c37960e88e0cb4ae72ab06fad295a8dbe7e00ab832742dffe5d"

