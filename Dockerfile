# Multi steps build file example
# we want to run nginx server, but we want to have the results from the build in the frontend here too

# FROM baseImage:tag as stage -> set the base image to use any subsequent instructions that follow
# the sole purpose of this phase, is to install deps and build the applicaiton
FROM node:16-alpine as builder
WORKDIR '/app'
COPY package.json .
RUN npm install
COPY . .
CMD ["npm", "run", "start"]

# second stage of the image we actually want to build
FROM nginx
# copy over something from a phase
COPY --from=builder /app/build /usr/share/nginx/html