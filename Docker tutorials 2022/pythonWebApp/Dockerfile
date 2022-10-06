# syntax=docker/dockerfile:1
#My image inherites from "python" image
FROM python:3.10.2-bullseye
WORKDIR /app
#host: your PC, laptop, cloud server,...
#Copy from "host" to "container"
COPY requirements.txt requirements.txt
#Run this command in the container
RUN pip3 install -r requirements.txt
COPY . .
#Run command in container
CMD [ "python3", "-m" , "flask", "run", "--host=0.0.0.0"]