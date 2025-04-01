FROM nginx:latest

# Install gettext for envsubst
RUN apt-get update && apt-get install -y --no-install-recommends gettext-base

# Remove default nginx configuration
RUN rm /etc/nginx/conf.d/default.conf

# Copy your configuration template to the container
COPY nginx.conf.template /etc/nginx/templates/nginx.conf.template

# Create an entrypoint script to handle template rendering and nginx startup
COPY entrypoint.sh /docker-entrypoint.d/

# Make the entrypoint script executable
RUN chmod +x /docker-entrypoint.d/entrypoint.sh

# Expose the port (if you're using a variable, expose the default as well)
EXPOSE 80