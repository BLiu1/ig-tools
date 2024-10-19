#!/bin/bash

# run in directory with .jpg images to add letterboxes or pillarboxes to bring image dimensions to 1080x1350
# ignores images that are already 1080x1350 in dimensions
# if first arg is "white" then only white border is added
# if first arg is "black" then only black border is added
# otherwise both versions are created 

BGCOLOR=${1:-"both"}
IMAGE=${2:-""}

apply_border() {
	if [ $(magick identify -ping -format '%w' "$f") -ne 1080 ] || [ $(magick identify -ping -format '%h' "$f") -ne 1350 ]
    then
        if [ "$BGCOLOR" != "black" ]
        then
            magick "$f" -colorspace RGB -resize '1080x1350' -gravity center -background white -extent '1080x1350' -colorspace sRGB -quality 90 -set filename:f '%t(white border).%e' '%[filename:f]'
        fi
        if [ "$BGCOLOR" != "white" ]
        then
            magick "$f" -colorspace RGB -resize '1080x1350' -gravity center -background black -extent '1080x1350' -colorspace sRGB -quality 90 -set filename:f '%t(black border).%e' '%[filename:f]'
        fi
    fi
}

if [ "$IMAGE" = "" ]
then
	for f in *.jpg
	do
    	apply_border
	done
else
	f="$IMAGE"
	apply_border
fi
