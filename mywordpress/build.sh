#!/bin/bash


base_path="$(pwd)"


cd $base_path/src/docker
./build-containers.sh

cd $base_path/src/nginx
./enable-site.sh

cd $base_path


echo "Build Complete. $(date)."