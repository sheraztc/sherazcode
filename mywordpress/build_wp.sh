#!/bin/bash


# Var Names
project_name="test_wordpress"
project_network="${project_name}_network"
project_db="${project_name}_db"
password="password"

# Stop
echo "Stopping..."
docker stop $project_name
docker rm $project_name

docker run --detach \
    -p 8080:80 \
    --name test_wordpress \
    --env WORDPRESS_DB_HOST=test_wordpress_db \
    --env WORDPRESS_DB_USER=test_wordpress_db \
    --env WORDPRESS_DB_PASSWORD=password \
    --network test_wordpress_network \
    wordpress


echo "Complete $(date)"