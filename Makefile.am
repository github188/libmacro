ACLOCAL_AMFLAGS = -I m4
lib_LTLIBRARIES = libmacro.la
libmacro_la_SOURCES = libmacro.c
include_HEADERS = libmacro.h kernel_list.h
libmacro_la_LDFLAGS = -version-info @lt_major@:@lt_revision@:@lt_age@
libmacro_la_CFLAGS = -Werror

noinst_PROGRAMS = test_libmacro
test_libmacro_SOURCE = test_libmacro.c
test_libmacro_LDADD = -llog
