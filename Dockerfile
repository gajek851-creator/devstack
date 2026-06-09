FROM nginx:alpine
RUN echo "<h1>Built by Jenkins from GitHub</h1>" \
    > /usr/share/nginx/html/index.html
