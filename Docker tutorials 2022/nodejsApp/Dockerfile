# syntax=docker/dockerfile:1
#Docker images can be inherited from other images
FROM node:latest
ENV NODE_ENV=production
WORKDIR /app
#Copy from Host to Image
COPY ["package.json", "package-lock.json*", "./"]
#Copy all ? NO!
COPY . .
#Run command in the image 
RUN yarn install
RUN npm install -g nodemon
#run inside a container
CMD [ "yarn", "run:dev"]