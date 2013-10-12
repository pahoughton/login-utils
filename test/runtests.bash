#!/bin/bash
#
set -x

top_srcdir=$1
package=$2
version=$3
test_inst_dir=$4

# use full paths
mydir=`pwd`
pushd "${top_srcdir}"
top_srcdir=`pwd`
popd
pushd "$test_inst_dir"
test_inst_dir=`pwd`
popd

srcdir=`pwd`/"$package-$version"

echo $srcdir

pushd "$srcdir" > /dev/null
[ -f configure ] || echo no configure fix dist target

./configure --prefix="$test_inst_dir" || exit 2
make && make install hide=

popd

tfexists_notfound=0

function tfexists {
  if [ -z "$1" ] ; then
    echo 'BUG: tfexists w/o arg'
    exit 3
  fi
  if [ -f "$1" ] ; then
    echo "  provides $1"
  else
    echo "  FAILED to provide '$1'"
    let tfexists_notfound++ 
  fi

}

echo "Test Start $package $version"


exp_files='.bash_aliases .bash_profile .bash_profile_user .bashrc .bash_setldlibpath'

pushd "$test_inst_dir/$HOME" > /dev/null

echo "Feature: installes bash config files"
for fn in $exp_files ; do
    tfexists "$fn"
done

echo "Feature: installes X11 config files"
for fn in .Xdefaults ; do
    tfexists "$fn"
done

if [ $tfexists_notfound -gt 0 ] ; then
  echo "FAIL! missing files"
  exit 1
fi

unset OSNAME
unset have_bashrc
unset have_bash_profile
. .bash_profile > $srcdir/bash_profile.out 2>&1 <<EOF

EOF

if [ -z "$OSNAME" ] ; then
  echo "FAIL! OSNAME not set"
  exit 2
else
  echo "Feature: OSNAME set by config."
  echo "  provides OSNAME set to ${OSNAME}"
fi

echo
echo "Test Stop All Tests succeeded!"
exit 0
