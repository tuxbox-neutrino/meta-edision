FILESEXTRAPATHS_prepend := "${THISDIR}/files:"

SRC_URI_append += "file://chromium/0001-Add-initial-support-for-V4L2-mem2mem-decoder.patch;patchdir=src/3rdparty \
		   file://chromium/0002-Replace-hbbtv-responses-with-application-xhtml-xml.patch;patchdir=src/3rdparty \
"

