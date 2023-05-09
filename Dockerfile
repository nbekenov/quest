# Use an official Node.js runtime as a parent image
FROM node:20

# Set the working directory to /app
WORKDIR /app

# Copy the package.json and package-lock.json files to the container
COPY package*.json ./

# Install the dependencies
RUN npm ci

# Copy the rest of the application code to the container
COPY . .

# Expose the port that your application listens on
EXPOSE 3000

# healthcheck to ensure that the application is running properly
HEALTHCHECK --interval=30s --timeout=3s \
  CMD curl --fail http://localhost:3000/ || exit 1

# Start the application
CMD ["npm", "start"]
