SRCDATE = "20201013"
KOFILES = "brcmstb-${MACHINE} brcmstb-decoder ci si2183 avl6862 avl6261"

require edision-dvb-modules.inc

SRC_URI[sha256sum] = "e8ceacaeb7ca7b385730749a42a39039f7f7037da974de76b7b48e6420c8bfc4"

PROVIDES = "virtual/dvb-driver"
RPROVIDES_${PN} = "virtual/dvb-driver"

COMPATIBLE_MACHINE = "osmio4k"
