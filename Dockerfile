# Docker Image which is used as foundation to create
# a custom Docker Image with this Dockerfile
FROM node:10-alpine AS BUILD_IMAGE
 
# A directory within the virtualized Docker environment
# Becomes more relevant when using Docker Compose later
WORKDIR /usr/src/app
 
# Copies package.json and package-lock.json to Docker environment
COPY package*.json ./
 
# Installs all node packages
RUN npm install
 
# Copies everything over to Docker environment
COPY . .
 
# Setting up the running image
FROM node:10-alpine 

WORKDIR /usr/src/app

COPY --from=BUILD_IMAGE /usr/src/app .
 
# Uses port which is used by the actual application
EXPOSE 4100
 
# Finally runs the application
CMD [ "npm", "start" ]
