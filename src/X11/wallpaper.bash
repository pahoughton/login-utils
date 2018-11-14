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

screens=`xrandr -q | grep ' connected ' | wc -l | cut -d ' ' -f 1`

if [ -f $picfn ] ; then
  onepic=`head -1 $picfn`
  if [ -f $onepic ] ; then
    piccnt=`wc -l $picfn | cut -d' ' -f 1`
  else
    piccnt=0
  fi
else
  piccnt=0
fi

if [ $piccnt -lt $screens ]; then
  echo finding images in $walldir
  find $walldir -follow -type f |
    egrep -v '(bash|xml|avi|mpg|mp4|m4v|mov)$' |
    sort -R > $picfn
  piccnt=`wc -l $picfn | cut -d' ' -f 1`
fi

if [ $piccnt -lt $screens ]; then
  echo ERROR not enough picts"($piccnt)" for screens"($screens)" aborting
  exit 2
fi

echo wallpaper starting with $piccnt pics $screens screens $delay sec delay
updatebg() {
  while true ; do
    mstate=`xset -q | grep Monitor | sed 's~^ *~~'`
    if [ "$mstate" = "Monitor is On" ] ; then
      wallpics=()
      for ((s = 0 ; s < $screens; s++)) ; do
	imgfn="`shuf -n 1 $picfn`"
	wallpics+=("$imgfn")
	echo `/bin/date +%F.%H:%M:%S` $imgfn >> ~/.wallpaper-history
      done
      pics="${wallpics[@]}"
      hasphoto=`echo $pics | sed -E 's~photos|women~~i'`
      feh_args='--bg-fill'
      if [ "$hasphoto" != "$pics" ] ; then
	feh_args='--bg-max'
      fi
      # echo feh $feh_args ${wallpics[@]}
      # echo cnt:${#wallpics[@]}:"${wallpics[@]}"
      feh $feh_args "${wallpics[@]}"
    else
      echo "`/bin/date +%F.%H:%M:%S` Monitor off" >> ~/.wallpaper-history
    fi
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
