#!/bin/bash

# https://gist.github.com/mihow/9c7f559807069a03e302605691f85572
if [ -f .env ]
then
  export $(cat .env | sed 's/#.*//g' | xargs)
fi

mkdir -p $path_db
mkdir -p $path_wp_content

echo $project_name

# if [[ "$#" -eq 0  ||  "$1" == "build" ]];
# then
#     # Stop
#     echo "Stopping..."
#     docker stop $project_name
#     docker stop $project_db
#     docker stop $project_name

#     # Clean
#     echo "Cleaning..."
#     docker network rm $project_network
#     docker rm $project_db

# elif [ "$1" == "restart" ];
# then
#     echo "Restart"
# fi

echo "Complete $(date)"