#!/bin/bash
for d in ./images/*; do
 echo $d
convert -define png:size=500x300 $d -auto-orient -thumbnail 200x120 -unsharp 0x.5 $d
done

