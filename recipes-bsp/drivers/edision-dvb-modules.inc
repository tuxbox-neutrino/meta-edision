SUMMARY = "Hardware drivers for ${MACHINE}"
SECTION = "base"
PRIORITY = "required"
LICENSE = "CLOSED"
PACKAGE_ARCH = "${MACHINE}"
KV = "5.8.0"
PV = "${KV}+${SRCDATE}"
PR = "r0"

SRC_URI = "https://github.com/edision-open/edision-driver/releases/download/${SRCDATE}/${MACHINE}-drivers-${KV}-${SRCDATE}.zip"
S = "${WORKDIR}"

INHIBIT_PACKAGE_STRIP = "1"

do_compile() {
}
do_populate_sysroot() {
}

do_install() {
    install -d ${D}/lib/modules/${KV}/extra
    install -d ${D}/${sysconfdir}/modules-load.d
    for i in ${KOFILES} ; do
        install -m 0755 ${WORKDIR}/${i}.ko ${D}/lib/modules/${KV}/extra/${i}.ko
        echo ${i} >> ${D}/${sysconfdir}/modules-load.d/_${MACHINE}.conf
    done
}

FILES_${PN} += "${sysconfdir}/modules-load.d/_${MACHINE}.conf /lib/modules/${KV}/extra"
