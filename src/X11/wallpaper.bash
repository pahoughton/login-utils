#!/bin/bash
# 2016-11-19 (cc) <paul@pahoughton.net>
#

walldir=$HOME/Pictures/wallpapers
picfn=.wall-pic-list
if [ ! -f $picfn ] ; then
  find $walldir -follow -type f | sort -R > $picfn
fi
# set -x
piclist=(`cat $picfn`)
piccnt=${#piclist[@]}

if [ $piccnt == 0 ] ; then
   echo no pictures found in $walldir
   exit 1
fi

screens=`xrandr -q | grep ' connected ' | wc -l | cut -d ' ' -f 1`
echo screens $screens
updatebg() {
  delay=$1
  while true ; do
    wallpics=()
    for ((s = 0 ; s < $screens; s++)) ; do
      let "picnum = $RANDOM % $piccnt"
      wallpics+=("${piclist[$picnum]}")
      echo $picnum ${piclist[$picnum]} >> ~/.wallpaper-history
    done
    feh --bg-fill ${wallpics[@]}
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
