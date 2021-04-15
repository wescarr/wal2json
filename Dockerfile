ARG DOCKER_ARCH=amd64

FROM $DOCKER_ARCH/postgres:9.6-alpine as build
RUN apk add --no-cache --virtual .build-deps gcc git make musl-dev pkgconf diffutils
COPY . /wal2json
WORKDIR /wal2json
RUN make && make install

FROM $DOCKER_ARCH/postgres:9.6-alpine
COPY --from=build /usr/local/lib/postgresql/wal2json.so /usr/local/lib/postgresql/
COPY /docker-entrypoint-initdb.d /docker-entrypoint-initdb.d
