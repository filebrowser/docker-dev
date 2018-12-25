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

curl -fsSL $( \
  curl -s https://api.github.com/repos/docker/docker-credential-helpers/releases/latest \
  | grep "browser_download_url.*pass-.*-amd64"  \
  | cut -d : -f 2,3 \
  | tr -d \" \
) | tar xv -C /go/bin

chmod + /go/bin/docker-credential-pass
