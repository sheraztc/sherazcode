#!/bin/bash
sudo rm -rf data
# Var Names
project_name="test_wordpress"
project_network="${project_name}_network"
project_db="${project_name}_db"
password="password"

# Var Paths
path_base="$(pwd)"
path_db="${path_base}/data/db"
mkdir -p $path_db
path_wp_content="${path_base}/data/wp-content"
mkdir -p $path_wp_content


if [[ "$#" -eq 0  ||  "$1" == "build" ]];
then
    # Stop
    echo "Stopping..."
    docker stop $project_name
    docker stop $project_db
    docker stop $project_name

    # Clean
    echo "Cleaning..."
    docker network rm $project_network
    docker rm $project_db

    # Build
    echo "Building..."
    docker network create --driver=bridge $project_network

    docker run --detach \
        -p 3306:3306 \
        -p 33060:33060 \
        --name $project_db \
        --env="MYSQL_ROOT_PASSWORD=password123" \
        --env="MYSQL_DATABASE=$project_db" \
        --env="MYSQL_USER=$project_db" \
        --env="MYSQL_PASSWORD=password123" \
        -v $path_db:/var/lib/mysql \
        --network $project_network \
        -d mysql

        

elif [ "$1" == "restart" ];
then
    echo "Restart"
fi

echo "Complete $(date)"