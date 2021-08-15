#!/bin/bash
# Temporary Remove commands. Remove them
sudo rm -rf data
docker rm -f $(docker ps -a -q)


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

    # Clean
    echo "Cleaning..."
    docker network rm $project_network
    docker rm $project_db
    docker rm $project_name

    # Build
    echo "Building..."
    docker network create --driver=bridge $project_network

    docker run --detach \
        -p 3306:3306 \
        -p 33060:33060 \
        --name $project_db \
        --env="MYSQL_ROOT_PASSWORD=${password}" \
        --env="MYSQL_DATABASE=${project_db}" \
        --env="MYSQL_USER=${project_db}" \
        --env="MYSQL_PASSWORD=${password}" \
        -v $path_db:/var/lib/mysql \
        --network $project_network \
        mysql

    docker run --detach \
        -p 8080:80 \
        --name $project_name \
        --env="WORDPRESS_DB_HOST=${project_db}" \
        --env="WORDPRESS_DB_USER=${project_db}" \
        --env="WORDPRESS_DB_PASSWORD=${password}" \
        --network $project_network \
        wordpress

elif [ "$1" == "restart" ];
then
    echo "Restart"
fi

echo "Complete $(date)"