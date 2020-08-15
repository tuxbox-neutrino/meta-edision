require libv3d.inc

PR = "r1"

PROVIDES = "virtual/libgles2 virtual/egl"

RPROVIDES_${PN} += "virtual/egl"
RPROVIDES_${PN} += "virtual/libgles2"
