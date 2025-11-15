ffmpeg -an -i $1 -filter:v "setpts=PTS/$2" $3
