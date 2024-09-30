# Copyright 2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

#PYTHON_COMPAT=(python3_{4..13})
PYTHON_COMPAT=(python3_12)
DISTUTILS_USE_PEP517=setuptools
inherit distutils-r1 pypi

SRC_URI="$(pypi_sdist_url "${PN}" "${PV}")"

DESCRIPTION="An improved Python library to control i3wm and sway."
HOMEPAGE="https://github.com/altdesktop/i3ipc-python"

LICENSE="BSD"
SLOT="0"
KEYWORDS="**"

REQUIRED_USE=${PYTHON_REQUIRED_USE}


DEPEND="
	${PYTHON_DEPS}
	dev-python/python-xlib
"
RDEPEND="${DEPEND} ${PYTHON_DEPS}"
BDEPEND="
	${PYTHON_DEPS}
	test? (
		dev-python/pytest
	)
"

IUSE="+test"

RESTRICT="!test? ( test )"

src_prepare() {
	rm -f ${S}/Makefile
	eapply_user
}

distutils_enable_tests pytest
python_test() {
	epytest
}
