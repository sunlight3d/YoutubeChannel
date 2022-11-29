shm = shared memory

docker run -d \
	--env-file ./oracle_db_env.dat \
	-p 1522:1521 \
	--name oracle-standard-container \
	--shm-size="8g" \
	--volume oracle-db:/opt/oracle/oradata \	
	container-registry.oracle.com/database/standard:latest

ls -la ~/Library/Containers/com.docker.docker/Data/vms

docker rm -f oracle-standard-container 

docker-compose -f ./docker-compose.yml up -d

docker-compose -f ./docker-compose.yml down 

Install Oracle Developer and use it