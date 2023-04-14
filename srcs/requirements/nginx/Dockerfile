FROM alpine:3.16

RUN apk update && apk upgrade && apk add --no-cache nginx

# port 443
EXPOSE 443

# deamon is a background process
CMD ["nginx", "-g", "daemon off;"]
