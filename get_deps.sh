#!/bin/sh

#-- go.rice

go get github.com/GeertJohan/go.rice/rice

#-- goreleaser

curl -sL https://git.io/goreleaser -o /go/bin/goreleaser

chmod +x /go/bin/goreleaser

#-- docker

curl -fsSL https://download.docker.com/linux/static/edge/x86_64/docker-18.05.0-ce.tgz | tar xvz --strip-components=1 docker/docker -C /go/bin

chmod +x /go/bin/docker

#-- docker-credential-pass

PASS_URL="$(curl -s https://api.github.com/repos/docker/docker-credential-helpers/releases/latest \
  | grep "browser_download_url.*pass-.*-amd64" \
  | cut -d : -f 2,3 \
  | tr -d \")"

if [ "$(echo "$PASS_URL" | cut -c2-6)" != "https" ]; then
  PASS_URL="https://github.com/docker/docker-credential-helpers/releases/download/v0.6.0/docker-credential-pass-v0.6.0-amd64.tar.gz"
fi

curl -fsSL "$PASS_URL" | tar xv -C /go/bin

chmod + /go/bin/docker-credential-pass
