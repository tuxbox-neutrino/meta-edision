require libv3d.inc

PR = "r1"

SRC_URI[md5sum] = "394b941103c405a36abe2ab46dcaf761"
SRC_URI[sha256sum] = "3c01b5de6535f4d34ef6157703fcd16807b971cfa403dba0f26340c41169a268"

PROVIDES = "virtual/libgles2 virtual/egl"
RPROVIDES_${PN} = "virtual/libgles2 virtual/egl"

