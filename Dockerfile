FROM golang:alpine

ENV CGO_ENABLED 0

RUN apk --no-cache -U upgrade && apk --no-cache add ca-certificates yarn git curl dos2unix

COPY get_deps.sh ./get_deps.sh

RUN dos2unix get_deps.sh && chmod +x ./get_deps.sh && ./get_deps.sh && rm get_deps.sh
