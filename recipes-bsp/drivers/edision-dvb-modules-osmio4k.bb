SRCDATE = "20200819"
KOFILES = "brcmstb-${MACHINE} brcmstb-decoder ci si2183 avl6862 avl6261"

require edision-dvb-modules.inc

SRC_URI[sha256sum] = "164eb6fab3e10f20824706adae8bcdfaf3fcb07f6ba6df4ded0537ff70dab0e1"

PROVIDES = "virtual/dvb-driver"
RPROVIDES_${PN} = "virtual/dvb-driver"

COMPATIBLE_MACHINE = "osmio4k"
