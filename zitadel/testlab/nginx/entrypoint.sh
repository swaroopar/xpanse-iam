#!/bin/bash
set -e

# Render the nginx configuration file using environment variables
envsubst < /etc/nginx/templates/nginx.conf.template > /etc/nginx/conf.d/default.conf

# Start nginx
exec nginx -g "daemon off;"