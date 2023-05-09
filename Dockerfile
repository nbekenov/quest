# Use an official Node.js runtime as a parent image
FROM node:20-bullseye-slim

# set the current mode
ENV NODE_ENV=production

# Set the working directory to /app
WORKDIR /usr/src/app

# Copy the application code to the container
COPY --chown=node:node . .

# Install the dependencies
RUN npm ci --only=production

# Expose the port that your application listens on
EXPOSE 3000

USER node

# Start the application
CMD ["node", "src/000.js"]
