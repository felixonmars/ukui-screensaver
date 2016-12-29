#!/bin/sh
# Run this to generate all the initial makefiles, etc.

srcdir=`dirname $0`
test -z "$srcdir" && srcdir=.

PKG_NAME="kylin-screensaver"

(test -f $srcdir/configure.ac) || {
    echo -n "**Error**: Directory "\`$srcdir\'" does not look like the"
    echo " top-level $PKG_NAME directory"
    exit 1
}

which kylin-autogen || {
    echo "You need to install kylin-common from the KYLIN Git"
    exit 1
}

REQUIRED_AUTOMAKE_VERSION=1.9
KYLIN_DATADIR="$kylin_datadir"

. kylin-autogen
