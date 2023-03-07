# Specify the base image
FROM node:14-alpine

# Set the working directory in the container
WORKDIR /app

# Copy the application files to the container
COPY . .

# Install dependencies
RUN npm install

# Build the Next.js application
RUN npm run build

# Set the environment variables
ENV NODE_ENV production
ENV PORT 3000

# Expose the port used by the application
EXPOSE 3000

# Start the application
CMD ["npm", "run", "start"]
