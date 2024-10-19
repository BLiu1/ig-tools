#!/bin/bash

# uses exiftool to extract ratings from older Fujifilm cameras' metadata to XMP sidecar files

IMAGE=${1:-""}
exiftool -ext JPG -tagsfromfile "@" "-xmp:Rating<MakerNotes:Rating" -srcfile %d%f.xmp "$IMAGE"