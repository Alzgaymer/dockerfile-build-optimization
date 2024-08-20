ARG BUILD_TARGET
ARG BUILD_PROJECT

FROM golang:1.22 AS base

ARG BUILD_TARGET
ARG BUILD_PROJECT

# oneof server or consumer
ENV TARGET_BINARY=${BUILD_TARGET}
# oneof some-project-one/two
ENV TARGET_PROJECT=${BUILD_PROJECT}

WORKDIR /app

COPY go.mod /app

COPY . /app

ENV BINARY=${TARGET_PROJECT}-${TARGET_BINARY}

RUN /app/log.envs.sh

RUN CGO_ENABLED=0 \
    go build -o /app/bin/${BINARY}\
     /app/some-project/${TARGET_PROJECT}/cmd/${TARGET_BINARY}/main.go


FROM alpine

ARG BUILD_TARGET
ARG BUILD_PROJECT

# oneof server or consumer
ENV TARGET_BINARY=${BUILD_TARGET}
# oneof some-project-one/two
ENV TARGET_PROJECT=${BUILD_PROJECT}

ENV BINARY=${TARGET_PROJECT}-${TARGET_BINARY}

WORKDIR /app

COPY docker-entrypoint.sh ./
COPY log.envs.sh ./

COPY --from=base /app/bin/${BINARY} ./

ENTRYPOINT ["./docker-entrypoint.sh"]
