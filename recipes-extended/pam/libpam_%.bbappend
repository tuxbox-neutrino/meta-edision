do_install_append() {
	echo "QT_QPA_EGLFS_INTEGRATION=eglfs_brcmstb" >> ${D}${sysconfdir}/environment
}
