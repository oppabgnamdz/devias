# Use the official Node.js image as a base
FROM node:14 AS build

# Set the working directory in the container
WORKDIR /app

# Copy package.json and package-lock.json to the container
COPY package*.json ./

# Install dependencies
RUN npm install

# Copy the rest of the application code to the container
COPY . .

# Build the production version of the application
RUN npm run build

RUN npm run export

# Create a new image with Nginx as the base
FROM nginx:latest

# Copy the production build files from the previous stage to the container
COPY --from=build /app/out /usr/share/nginx/html

# Copy the Nginx configuration file to the container
COPY nginx.conf /etc/nginx/conf.d/default.conf

# Expose port 80
EXPOSE 81

# Start Nginx
CMD ["nginx", "-g", "daemon off;"]
