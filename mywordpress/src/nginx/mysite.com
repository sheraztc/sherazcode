# Tomcat Proxy pass
server {
  listen 80;  
  server_name www.sherazchaudhry.com;

  location / {
    proxy_pass http://localhost:8080;  
  }
}
