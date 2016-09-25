#!/bin/sh

CMD=$0
PLATFORM=$1
DIR=${PWD}

PACKNAME=libmacro
VERSION=1.0.3
PACKAGE="${PACKNAME}_$VERSION"

usage()
{
	echo "==== usage ===="
	echo "$CMD [platform]"
	echo "<platform>: arm, x86(default)"
}

do_make()
{
	./configure ${HOST}
	make
}

do_package()
{
	make distclean
	rm .libs/ -fr
	rm .deps/ -fr
	rm ./debian/.debhelper/ -fr
	cd ../
	if [ -f $PACKAGE.orig.tar.xz ]; then
		rm $PACKAGE.orig.tar.xz
	fi
	echo "$PACKAGE.orig.tar.xz"
	tar -Jcvf $PACKAGE.orig.tar.xz $PACKNAME \
	--exclude $PACKNAME/.git \
	--exclude $PACKNAME/.libs \
	--exclude $PACKNAME/.deps \
	--exclude $PACKNAME/.pc
	cd $DIR
	#debchange
	dpkg-buildpackage
}

do_ppa()
{
	rm .libs/ -fr
	dpkg-buildpackage -S
	debuild -S -k802EB8DC
	dput ppa:gozfree/ppa ../${PACKAGE}_source.changes
}

do_build()
{
	case $PLATFORM in
	"arm")
		HOST="--host=arm-linux-gnueabihf";;
	"deb")
		do_package;
		exit;;
	"ppa")
		do_ppa;
		exit;;
	"help")
		usage;
		exit;;
	"clean")
		make clean;
		exit;;
	*)
		HOST="";;
	esac
}

do_build
do_make
