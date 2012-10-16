# Maintainer: Emil Renner Berthing <esmil@mailme.dk>

pkgname=lem
pkgver=0.3
pkgrel=1
pkgdesc='A Lua Event Machine'
arch=('i686' 'x86_64' 'armv5tel' 'armv7l')
url='https://github.com/esmil/lem'
license=('GPL')
depends=('glibc')
source=()

build() {
  cd "$startdir"

  ./configure --prefix=/usr --with-lua=builtin
  make
}

package() {
  cd "$startdir"

  make DESTDIR="$pkgdir/" install
}

# vim:set ts=2 sw=2 et:
