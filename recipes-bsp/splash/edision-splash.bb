SUMMARY = "Edision splash"
SECTION = "base"
PRIORITY = "required"
LICENSE = "CLOSED"
PACKAGE_ARCH = "${MACHINE_ARCH}"

inherit deploy

PR = "r0"

S = "${WORKDIR}"

SRC_URI = "file://splash.bin"

ALLOW_EMPTY_${PN} = "1"

do_deploy() {
    install -m 0644 splash.bin ${DEPLOYDIR}/splash.bin
}

addtask deploy before do_build after do_install
