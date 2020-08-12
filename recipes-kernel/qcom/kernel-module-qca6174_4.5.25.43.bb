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

SRC_URI[md5sum] = "470372b7c7614059faa49afe13576fee"
SRC_URI[sha256sum] = "d6554ffc91f130f1020ad1d317ce44ee7b5baf19743a3fd0946f5210a14aa5d6"

