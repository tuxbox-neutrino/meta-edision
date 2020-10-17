
SRCDATE = "20201013"
KOFILES = "brcmstb-${MACHINE} brcmstb-decoder ci si2183 avl6862 avl6261"

require edision-dvb-modules.inc

SRC_URI[sha256sum] = "d3f742e31d555021462cb66ebfc6dde3dde78aa8016b09fed48cf4cd9485b222"

PROVIDES = "virtual/dvb-driver"
RPROVIDES_${PN} = "virtual/dvb-driver"

COMPATIBLE_MACHINE = "osmio4kplus"

