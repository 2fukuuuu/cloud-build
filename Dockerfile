FROM node:20.18.0-alpine AS build
LABEL maintainer="Technology Solution Team"

# Arguments
ARG NODE_ENV="production"

# App Path
WORKDIR /app
RUN echo "Environment: ${NODE_ENV}"
COPY . /app

# Frontend
RUN npm install --production=false
RUN npm run build
RUN rm -rf node_modules

# Serve with Nginx
FROM nginx:alpine

# Copy React build to Nginx's public folder
COPY --from=build /app/build /usr/share/nginx/html

EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]