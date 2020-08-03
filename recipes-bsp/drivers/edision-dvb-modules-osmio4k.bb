KV = "5.5.16"
SRCDATE = "20200409"
KOFILES = "brcmstb-${MACHINE} ci si2183 avl6862 avl6261"

require edision-dvb-modules.inc

SRC_URI[md5sum] = "14fcbe09a3a084e03f7855fb72a2fe19"
SRC_URI[sha256sum] = "ad12e80aac610ef316532926f3007cb0f9324207ab7fe314a58376028e26755a"
SRC_URI[arm64.md5sum] = "b730d9894266c4dd8819d763c97e1ccf"
SRC_URI[arm64.sha256sum] = "b1ca99b86e36d25907ff7013a8476ce5f02848d21dae40d52f107de406da3ebb"

PROVIDES = "virtual/dvb-driver"
RPROVIDES_${PN} = "virtual/dvb-driver"

COMPATIBLE_MACHINE = "osmio4k"
