
KV = "5.5.16"
SRCDATE = "20200409"
KOFILES = "brcmstb-${MACHINE} ci si2183 avl6862 avl6261"

require edision-dvb-modules.inc

SRC_URI[md5sum] = "4952ae33725aa851dc15beb33b879371"
SRC_URI[sha256sum] = "a249100198a10eec27a8814ce2f4d7f7841ad267a347b87b516ba063c11c44a6"
SRC_URI[arm64.md5sum] = "2928f6c71d8d9d79b620fe35320c4686"
SRC_URI[arm64.sha256sum] = "94aa81b3991b1e5756f744b97deb50fa42a4237eb5509f3a274dc0916c291f34"

PROVIDES = "virtual/dvb-driver"
RPROVIDES_${PN} = "virtual/dvb-driver"

COMPATIBLE_MACHINE = "osmio4kplus"
