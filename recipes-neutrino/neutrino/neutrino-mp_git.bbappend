FILESEXTRAPATHS_prepend := "${THISDIR}/files:"

SRC_URI_append = "file://0002-rcinput.cpp-fix-key-repeat-for-osmio4k.patch"

EXTRA_OECONF_append += "--with-boxtype=armbox \
                        --with-boxmodel=${MACHINE} \
                        --with-stb-hal-includes=${STAGING_INCDIR}/libstb-hal \
"
