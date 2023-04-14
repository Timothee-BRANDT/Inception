FROM alpine:3.16

# --no-cache flag to avoid caching package index files in the final image, which helps reduce the image size.
RUN apk update && apk upgrade && apk add --no-cache nginx

EXPOSE 443

# The -g "daemon off;" option prevents Nginx from running in the background, which is necessary when running as the main process in a Docker container.
CMD ["nginx", "-g", "daemon off;"]
