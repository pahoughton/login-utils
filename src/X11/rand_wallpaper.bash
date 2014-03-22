#!/bin/bash
## rand_wallpaper.bash - 2014-03-01 12:44
#
# Copyright (c) 2014 Paul Houghton <paul4hough@gmail.com>
#
echo $$ > ~/.rand_wallpaper.pid
set -m
freq=${1:-600}
# echo $freq
while true; do
  backgrounds=`find ~/.desktop_pictures -type f | sort -R`
  echo pics `echo $backgrounds | wc -w`
  for pic in $backgrounds; do
    echo $pic > ~/.wallpaper.pic
    if grep '/background/' ~/.wallpaper.pic > /dev/null ; then
      display  -backdrop -background '#3f3f3f' -flatten -window root   \
	-gravity Center -resize 2560x1440^ -crop 2560x1440+0+0 +repage \
	-resize 2560x1440^                                             \
	"${pic}"
    else
      display  -backdrop -background '#3f3f3f' -flatten  \
	-resize 2560x1440^ -window root  -gravity Center \
	"${pic}"
    fi
    sleep $freq &
    echo $! > ~/.wallpaper-sleep.pid
    fg %1 > /dev/null
  done
done
