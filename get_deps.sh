#!/bin/sh

#-- go.rice

echo "INSTALL go.rice"

go get github.com/GeertJohan/go.rice/rice

#-- goreleaser

echo "INSTALL goreleaser"

curl -sL https://git.io/goreleaser -o /go/bin/goreleaser

chmod +x /go/bin/goreleaser

#-- docker

echo "INSTALL docker CLI"

curl -fsSL https://download.docker.com/linux/static/edge/x86_64/docker-18.05.0-ce.tgz | tar xvz --strip-components=1 docker/docker -C /go/bin

chmod +x /go/bin/docker

#-- docker-credential-pass

echo "INSTALL docker-credential-pass"

PASS_URL="$(curl -s https://api.github.com/repos/docker/docker-credential-helpers/releases/latest \
  | grep "browser_download_url.*pass-.*-amd64" \
  | cut -d : -f 2,3 \
  | tr -d \")"
PASS_URL="$(echo $PASS_URL | cut -c2-)"

if [ "$(echo "$PASS_URL" | cut -c1-5)" != "https" ]; then
  PASS_URL="https://github.com/docker/docker-credential-helpers/releases/download/v0.6.0/docker-credential-pass-v0.6.0-amd64.tar.gz"
fi

echo "PASS_URL: $PASS_URL"

curl -fsSL "$PASS_URL" | tar xv -C /go/bin

chmod + /go/bin/docker-credential-pass

#-- golangci-lint

echo "INSTALL golangci-lint"

#GOLANGCI_VER="v1.12.5"
GOLANGCI_VER="latest"

echo "GOLANGCI_VER: $GOLANGCI_VER"

curl -sfL https://install.goreleaser.com/github.com/golangci/golangci-lint.sh | sh -s -- -b $(go env GOPATH)/bin "$GOLANGCI_VER"
