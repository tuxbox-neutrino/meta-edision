FILESEXTRAPATHS_prepend := "${THISDIR}/files:"

SRC_URI_append += " \
	file://firstboot.sh \
	file://local.service \
	file://local.sh \
	file://imgbackup \
	file://-.mount \
	file://boot.mount \
	file://mnt-rootfs1.mount \
	file://mnt-rootfs2.mount \
	file://mnt-rootfs3.mount \
	file://mnt-rootfs4.mount \
	file://mount.sh \
	file://fstab \
"

do_install_append() {
	install -d ${D}${bindir} ${D}${sbindir} ${D}${systemd_unitdir}/system/multi-user.target.wants
 	install -m 0755 ${WORKDIR}/firstboot.sh  ${D}${sbindir}
	install -m 0755 ${WORKDIR}/local.sh ${D}${bindir}
	install -m 0755 ${WORKDIR}/imgbackup ${D}${bindir}
        install -m 0755 ${WORKDIR}/mount.sh ${D}${bindir}
        install -m 0644 ${WORKDIR}/local.service ${D}${systemd_unitdir}/system
        ln -sf /lib/systemd/system/local.service  ${D}${systemd_unitdir}/system/multi-user.target.wants
        install -m 0644 ${WORKDIR}/-.mount ${D}${systemd_unitdir}/system
	ln -sf /lib/systemd/system/-.mount  ${D}${systemd_unitdir}/system/multi-user.target.wants
	install -m 0644 ${WORKDIR}/boot.mount ${D}${systemd_unitdir}/system
	ln -sf /lib/systemd/system/boot.mount  ${D}${systemd_unitdir}/system/multi-user.target.wants
	install -m 0644 ${WORKDIR}/mnt-rootfs1.mount ${D}${systemd_unitdir}/system
	ln -sf /lib/systemd/system/mnt-rootfs1.mount  ${D}${systemd_unitdir}/system/multi-user.target.wants
	install -m 0644 ${WORKDIR}/mnt-rootfs2.mount ${D}${systemd_unitdir}/system
	ln -sf /lib/systemd/system/mnt-rootfs2.mount  ${D}${systemd_unitdir}/system/multi-user.target.wants
	install -m 0644 ${WORKDIR}/mnt-rootfs3.mount ${D}${systemd_unitdir}/system
	ln -sf /lib/systemd/system/mnt-rootfs3.mount  ${D}${systemd_unitdir}/system/multi-user.target.wants
	install -m 0644 ${WORKDIR}/mnt-rootfs4.mount ${D}${systemd_unitdir}/system
	ln -sf /lib/systemd/system/mnt-rootfs4.mount  ${D}${systemd_unitdir}/system/multi-user.target.wants
}
