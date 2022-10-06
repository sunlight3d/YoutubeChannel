App with multiple containers:
docker network create todo-app-network
docker run -d \
--name mysql-container \
--network todo-app-network \
--network-alias todo-app-network-alias \
-v todo-mysql-database:/var/lib/mysql \
-e MYSQL_ROOT_PASSWORD=Abc@123456789 \
-e MYSQL_DATABASE=todoDB \
-d mysql

docker exec -it mysql-container mysql -u root -p

Create another container, has the same network
it = interactive mode
docker run -it \
--network todo-app-network \
--name netshoot-container \
nicolaka/netshoot

dig = DNS lookup utility
dig todo-app-network-alias

Create another nodeJS container:
-w: working directory

pwd : current folder
docker run -dp 8002:8000 \
--name todo-app-container \
-w /app -v "$(pwd):/app" \
--network todo-app-network \
-e MYSQL_HOST=todo-app-network-alias \
-e MYSQL_USER=root \
-e MYSQL_PASSWORD=Abc@123456789 \
-e MYSQL_DB=todoDB \
node \
sh -c "yarn install && yarn run:dev"

docker logs todo-app-container

npm init -y
yarn add ronin-server ronin-mocks
npm install -g nodemon

=> You should create your own "custom image"
=> need a configuration file => Dockerfile 
"custom image" must based on an "existing image"

Build image from Dockerfile
docker build --tag node-mysql-image .
Rename your image:
docker tag node-mysql-image:latest node-mysql-image:v1.0.0

Remove unnecessary image(rmi = remove image):
docker rmi node-mysql-image:latest

How to push image to your Docker Hub ?
-Login, create a repository(public/private)
docker tag node-mysql-image:v1.0.0 sunlight4d/node-mysql-image:v1.0.0

docker push sunlight4d/node-mysql-image:v1.0.0

Create container from your "custom image":


docker run -dp 8002:8000 \
--name node-mysql-container \
-w /app -v "$(pwd):/app" \
--network todo-app-network \
-e MYSQL_HOST=todo-app-network-alias \
-e MYSQL_USER=root \
-e MYSQL_PASSWORD=Abc@123456789 \
-e MYSQL_DB=todoDB \
sunlight4d/node-mysql-image:v1.0.1 \
sh -c "yarn install && yarn run:dev"

Update version:
docker tag node-mysql-image:latest sunlight4d/node-mysql-image:v1.0.1
docker push sunlight4d/node-mysql-image:v1.0.1

Create container with params/configurations
Put all params/configurations into a .yml file => Docker compose
docker-compose version

app services = multiple containers

Remove some containers:
docker rm -f netshoot-container
docker rm -f todo-app-container

docker rm -f node-mysql-container
docker rm -f mysql-container
docker network rm todo-app-network  

Start up the application stack:
-f : file
-d : detach(background mode)
docker-compose -f ./node-mysql-docker-composer.yml up -d 

Deploy your app to server => Kubenetes cluster