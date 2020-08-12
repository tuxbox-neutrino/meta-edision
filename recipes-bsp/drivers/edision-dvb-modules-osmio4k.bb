SRCDATE = "20200810"
KOFILES = "brcmstb-${MACHINE} ci si2183 avl6862 avl6261"

require edision-dvb-modules.inc

SRC_URI[sha256sum] = "e76408c3a0cfa0c70c1a507aa4c9cf6ae906383744d1a03a26f94594b4cc2160"

PROVIDES = "virtual/dvb-driver"
RPROVIDES_${PN} = "virtual/dvb-driver"

COMPATIBLE_MACHINE = "osmio4k"
