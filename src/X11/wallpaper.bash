#!/bin/bash
# 2016-11-19 (cc) <paul@pahoughton.net>
#

walldir=$HOME/Pictures/wallpapers
picfn=$HOME/.wallpaper-pic-list
if [ "$1" == 'reset' ] ; then
  rm $picfn
  shift
fi

delay=${1:-900}

if [ ! -f $picfn ] ; then
  find $walldir -follow -type f | grep -v '.mov$' | sort -R > $picfn
fi
# set -x
piclist=(`cat $picfn`)
piccnt=${#piclist[@]}

if [ $piccnt == 0 ] ; then
   echo $piccnt pictures found in $walldir
   exit 1
fi

screens=`xrandr -q | grep ' connected ' | wc -l | cut -d ' ' -f 1`
echo wallpaper starting with $piccnt pics $screens screens $delay sec delay
updatebg() {
  while true ; do
    wallpics=()
    for ((s = 0 ; s < $screens; s++)) ; do
      let "picnum = $RANDOM % $piccnt"
      wallpics+=("${piclist[$picnum]}")
      echo $picnum ${piclist[$picnum]} >> ~/.wallpaper-history
    done
    pics="${wallpics[@]}"
    hasphoto=`echo $pics | sed 's~photos~~i'`
    feh_args='--bg-fill'
    if [ "$hasphoto" != "$pics" ] ; then
      feh_args='--bg-max'
    fi
    feh $feh_args ${wallpics[@]}
    if [ -n "$delay" ] ; then
      sleep $delay &
      echo $! > ~/.wallpaper-sleep.pid
      wait $! 2>/dev/null
    else
      exit
    fi
  done
}

updatebg $* &
echo $! > ~/.wallpaper.pid
