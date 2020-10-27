SRC_URI = " file://0001-Add-initial-support-for-V4L2-mem2mem-decoder.patch"

PROVIDES += "virtual/kodi"
RPROVIDES_${PN} += "virtual/kodi"

INSANE_SKIP_${PN} += "file-rdeps"

EXTRA_OECMAKE = " \
    -DWITH_PLATFORM=edision-cortexa15 \
    -DWITH_FFMPEG=stb \
"
