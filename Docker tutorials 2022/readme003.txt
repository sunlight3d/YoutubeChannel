- Create a python Flask WebApp
- Build an image from this App
- Create container from this image and run

Install python => many ways
which python modules you've installed:
pip3 freeze
run app:
python3 -m flask run

Now we build my own image from the App
docker build --tag python-flask-app .
Do this later:
docker build --tag sunlight4d/python-flask-app:v1.0.0 .

Name your version:
docker tag python-flask-app:latest python-flask-app:v1.0.0

How to push image to your Docker Hub ?
-Login, create a repository(public/private)
docker tag python-flask-app:v1.0.0 sunlight4d/python-flask-app:v1.0.0


docker push sunlight4d/python-flask-app:v1.0.0

Remove images, pull again, then create container
#-v "$(pwd):/app" => Map this host's current folder to /app(container)

docker run -dp 5002:5000 \
--name python-flask-app-container \
--network mysql-python-app-network \
-v "$(pwd):/app" \
sunlight4d/python-flask-app:v1.0.0

docker logs python-flask-app-container

stop/start container:
docker restart python-flask-app-container

Test:
curl localhost:5002
curl localhost:5002/initdb

Update python code, add mysql container, add network, volume
docker volume create mysql-python-app-volume
docker volume create mysql-python-app-volume-config

docker network create mysql-python-app-network

Start mysql container:

--rm : automatic remove container after stop

docker run --rm -d \
-v mysql-python-app-volume:/var/lib/mysql \
-v mysql-python-app-volume-config:/etc/mysql \
--name mysql-flask-app-container \
-p 3309:3306 \
--network mysql-python-app-network -e MYSQL_ROOT_PASSWORD=Abc@123456789 \
mysql:8.0.28

Access mysql's command line inside mysql-flask-app-container:
docker exec -ti mysql-flask-app-container mysql -u root -p

How to add mysql package to python-flask-app-container:
- add mysql-connector to requirements.txt
- Rebuild image => sunlight4d/python-flask-app:v1.0.0
- Delete python-flask-app-container, then run python-flask-app-container again
- Put 2 containers: python-flask-app-container, mysql-flask-app-container
into the same network(mysql-python-app-network)
- Make sure that python-flask-app-container AND mysql-flask-app-container
ARE RUNNING

curl localhost:5002/initdb
curl localhost:5002/init_tables
curl localhost:5002/products

Create containers(python-flask-app-container AND mysql-flask-app-container) 
by using "Docker compose":
- Create the .yml file
- Remove containers, then build .yml file
docker-compose -f ./docker-compose.dev.yml up --build













