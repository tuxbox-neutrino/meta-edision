
SRCDATE = "20200810"
KOFILES = "brcmstb-${MACHINE} ci si2183 avl6862 avl6261"

require edision-dvb-modules.inc

SRC_URI[sha256sum] = "5d98f73801e90277ada356a28e6848b7d6218061f8cac3b5ed7a8cc239073f9d"

PROVIDES = "virtual/dvb-driver"
RPROVIDES_${PN} = "virtual/dvb-driver"

COMPATIBLE_MACHINE = "osmio4kplus"
