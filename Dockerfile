FROM golang:alpine

# oneof server or consumer
ARG BUILD_TARGET

ENV TARGET_BINARY=${BUILD_TARGET}

WORKDIR /app

COPY go.mod ./app

COPY . /app

RUN chmod +x /app/docker-entrypoint.sh

ENTRYPOINT ["/app/docker-entrypoint.sh"]
