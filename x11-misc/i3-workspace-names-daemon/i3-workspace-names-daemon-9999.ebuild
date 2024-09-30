# Copyright 2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=(python3_{6..13})
DISTUTILS_USE_PEP517=setuptools
inherit git-r3 distutils-r1

DESCRIPTION="Dynamically update workspace names in i3wm based on their content"
HOMEPAGE="https://github.com/i3-workspace-names-daemon/i3-workspace-names-daemon"
EGIT_REPO_URI="${HOMEPAGE}"
EGIT_BRANCH="master"

LICENSE="MIT"
SLOT="0"
KEYWORDS="**"  # just python

IUSE="+fontawesome +test"

RESTRICT="!test? ( test )"

# i3ipc also available in GURU (but packaged differently)
DEPEND="
	dev-lang/python
	dev-python/i3ipc
	x11-wm/i3
	fontawesome? ( media-fonts/fontawesome )
"
RDEPEND="${DEPEND}"
BDEPEND=""

distutils_enable_tests pytest
python_test() {
	epytest
}

pkg_postinst() {
	ewarn "Expected fontawesome-6.3.0 some glyphs may be different"
	elog "Create a ~/.config/.i3/app-icons.json"
	elog "Modify your i3 config to make this autostart"
	elog "Follow the README for extended documentation"
}
