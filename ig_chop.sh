#!/bin/bash

# first arg is image filename
# splits a long image into a series of tiles

IMAGE=${1:-""}

magick "$IMAGE" -colorspace RGB -resize x1350 -crop 1080x1350 -colorspace sRGB +repage +adjoin -set filename:f '%t' '%[filename:f] %01d.jpg'
