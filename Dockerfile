
FROM golang:1.22 AS base

ENV ROOT="github.com/Alzgaymer/dockerfile-build-optimization"

ARG BUILD_TARGET
ARG BUILD_PROJECT
ARG VERSION

# oneof server or consumer
ENV TARGET_BINARY=${BUILD_TARGET}
# oneof some-project-one/two
ENV TARGET_PROJECT=${BUILD_PROJECT}

ENV TARGET_VERSION=${VERSION}

RUN go install ${ROOT}/some-project/${TARGET_PROJECT}/cmd/${TARGET_BINARY}@${TARGET_VERSION}

FROM alpine

ARG BUILD_TARGET
ARG BUILD_PROJECT

# oneof server or consumer
ENV TARGET_BINARY=${BUILD_TARGET}
# oneof some-project-one/two
ENV TARGET_PROJECT=${BUILD_PROJECT}

WORKDIR /app

COPY docker-entrypoint.sh ./
COPY log.envs.sh ./

COPY --from=base /go/bin/${TARGET_BINARY} ./

ENTRYPOINT ["./docker-entrypoint.sh"]
