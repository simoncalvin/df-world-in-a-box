#!/bin/bash

set -e

Xvfb :1 -screen 0 1024x768x16 &

echo "Starting world gen"

./df_linux/df -gen 1 RANDOM "POCKET REGION"

echo "Creating output directory"

world=$(head -n 1 ./df_linux/region1-00030-01-01-world_history.txt)
world=${world// /_}

echo $world

mkdir -p /world_gen/$(hostname)/$world

echo "Copying output"

for path in ./df_linux/region1*; do
	file=$(basename $path)
	cp $path /world_gen/$(hostname)/${file/region1-00030-01-01/$world};
done

cp -r  ./df_linux/data/save/region1/ /world_gen/$(hostname)/$world

echo "Exited $0"


