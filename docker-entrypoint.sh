#!/bin/bash

set -e

Xvfb :1 -screen 0 1024x768x16 &

echo "Starting world gen"

./df_linux/df -gen 1 RANDOM "POCKET REGION" &

while [ 'ps -p $! > /dev/null' ]
do
	if [ -f ./df_linux/map_rejection_log.txt ] && [[ $(cat ./df_linux/map_rejection_log.txt | wc -l) -gt 32000 ]]
	then
		echo "Failed: too many rejections"

		cp ./df_linux/map_rejection_log.txt /world_gen/$(hostname)-map_rejection_log.txt

		exit 1
	fi
done

world=$(head -n 1 ./df_linux/region1-00030-01-01-world_history.txt)
world=${world// /_}

echo "Creating output directory for $world"

mkdir -p /world_gen/$(hostname)/$world

echo "Copying output to {volume}/$(hostname)"

for path in ./df_linux/region1*; do
	file=$(basename $path)
	cp $path /world_gen/$(hostname)/${file/region1/$world};
done

cp -frp  ./df_linux/data/save/region1 -T /world_gen/$(hostname)/$world

echo "Exited $0"


