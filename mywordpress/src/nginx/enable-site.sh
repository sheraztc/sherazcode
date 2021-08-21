#!/bin/bash

# vars
site_name="mysite.com"
nginx_root="/etc/nginx"

echo "Configuring ${site_name}"
cp -f $site_name ${nginx_root}/sites-available/${site_name}
# unlink ${nginx_root}/sites-enabled/default 2>/dev/null
unlink ${nginx_root}/sites-enabled/${site_name} 2>/dev/null
ln -s ${nginx_root}/sites-available/${site_name} ${nginx_root}/sites-enabled/


echo "Testing nginx configurations"
nginx -t


