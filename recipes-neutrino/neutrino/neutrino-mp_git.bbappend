FILESEXTRAPATHS_prepend := "${THISDIR}/files:"

EXTRA_OECONF_append += "--with-boxtype=armbox \
                        --with-boxmodel=${MACHINE} \
                        --with-stb-hal-includes=${STAGING_INCDIR}/libstb-hal \
"
