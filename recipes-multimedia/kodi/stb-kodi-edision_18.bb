COMPATIBLE_MACHINE = "osmio4k|osmio4kplus"

SRC_URI_remove = "file://0001-add-find-GLIB.patch \
           file://e2player.patch \
           file://0001-introduce-basic-GstPlayer.patch \
"

SRC_URI = "file://0001-Add-initial-support-for-V4L2-mem2mem-decoder.patch \
"

PROVIDES += "virtual/kodi"
RPROVIDES_${PN} += "virtual/kodi"
RDEPENDS_${PN} += "edision-libv3d"

EXTRA_OECMAKE = " \
    -DWITH_PLATFORM=edision-cortexa15 \
    -DWITH_FFMPEG=stb \
"
