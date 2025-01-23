# Distributed under the terms of the GNU General Public License v2

EAPI="7"
ETYPE="sources"
KEYWORDS="*"

HOMEPAGE="https://github.com/microsoft/WSL2-Linux-Kernel"

K_SECURITY_UNSUPPORTED="1"

inherit kernel-2
detect_version
detect_arch

RDEPEND="virtual/linux-sources"

DESCRIPTION="Microsoft WSL2 Standard Linux 5.15.167.4"

SRC_URI="https://github.com/microsoft/WSL2-Linux-Kernel/archive/refs/tags/linux-msft-wsl-5.15.167.4.tar.gz -> ${P}.tar.gz"

src_unpack() {
	cd "${WORKDIR}"
		unpack ${A}

	if [[ -d "linux" ]]; then
		debug-print "Moving linux to linux-${KV_FULL}"
		mv linux linux-${KV_FULL} \
			|| die "Unable to move source tree to ${KV_FULL}."
	else
		debug-print "moving src to linux-${KV_FULL} "
			mv *-linux-*${KV_MAJOR}.${KV_MINOR}* linux-${KV_FULL} \
				|| die "Unable to move source tree to ${KV_FULL}."
	fi
	cd "${S}"

	# remove all backup files
	find . -iname "*~" -exec rm {} \; 2> /dev/null
}

pkg_postinst() {
	kernel-2_pkg_postinst
}

pkg_postrm() {
	kernel-2_pkg_postrm
}
