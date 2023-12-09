## BUILD STAGE
FROM node:14 as build-stage

WORKDIR /app

# Update platform dependencies
RUN apt-get update && apt-get install libsecret-1-0 -y

# Prepare native plugin
COPY ./cordova-plugin-moodleapp/package*.json /app/cordova-plugin-moodleapp/
RUN npm ci --prefix cordova-plugin-moodleapp
COPY ./cordova-plugin-moodleapp/ /app/cordova-plugin-moodleapp/
RUN npm run prod --prefix cordova-plugin-moodleapp

# Prepare node dependencies
COPY package*.json ./
COPY patches ./patches
RUN echo "unsafe-perm=true" > ./.npmrc
RUN npm ci --no-audit

# Build source
ARG build_command="npm run build:prod"
COPY . /app
RUN ${build_command}

## SERVE STAGE
FROM nginx:alpine as serve-stage

# Copy assets & config
COPY --from=build-stage /app/www /usr/share/nginx/html