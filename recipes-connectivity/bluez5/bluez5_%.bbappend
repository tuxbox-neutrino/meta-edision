FILESEXTRAPATHS_prepend := "${THISDIR}/files:"

# Do not start the service during system boot up

# Add patch for module bcm43xx
# Add patches for QCA modules with Qca6174 and Qca9377-3 chips
SRC_URI += " \
            file://0001-bluetooth-Add-bluetooth-support-for-QCA6174-chip.patch \
            file://0002-hciattach-set-flag-to-enable-HCI-reset-on-init.patch \
            file://0003-hciattach-instead-of-strlcpy-with-strncpy-to-avoid-r.patch \
"
