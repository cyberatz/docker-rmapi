FROM golang:alpine AS builder
RUN apk add -X http://dl-cdn.alpinelinux.org/alpine/edge/community \
     -X http://dl-cdn.alpinelinux.org/alpine/edge/main \
    alpine-sdk gnupg xz curl-dev sqlite-dev binutils-gold \
    autoconf automake ldc git

ENV PATH /go/bin:/usr/local/go/bin:$PATH
ENV GOPATH /go
#ENV SOURCEPATH ${GOPATH}/src/github.com/juruen/rmapi

RUN go get github.com/juruen/rmapi
RUN mkdir /usr/src && cd /usr/src/ && git clone https://github.com/juruen/rmapi.git --single-branch && \
    cd rmapi && git init 
    #&& git switch -c v2.4.6
ENV SOURCEPATH /usr/src/rmapi

RUN apk add --no-cache \
    bash

COPY . ${SOURCEPATH}

RUN set -x \
    && cd ${SOURCEPATH} \
    && go build . \
    && mv rmapi /usr/bin/rmapi


FROM alpine:latest

COPY --from=builder /usr/bin/rmapi /usr/bin/rmapi

RUN adduser -D -u 1000 user \
    && chown -R user /home/user

USER user

ENV USER user

WORKDIR /home/user

ENTRYPOINT [ "rmapi" ]

