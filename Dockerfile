FROM golang:alpine AS base

RUN apk add -U --no-cache git && \
  go get github.com/alecthomas/gometalinter && \
  gometalinter --install

FROM golang:alpine

COPY --from=base /go/bin /go/bin
COPY get_deps.sh ./get_deps.sh

ENV CGO_ENABLED 0

RUN apk --no-cache -U upgrade && apk --no-cache add ca-certificates yarn git curl dos2unix && \
  chmod +x get_deps.sh && ./get_deps.sh && rm get_deps.sh
