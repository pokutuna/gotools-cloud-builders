FROM golang:alpine

# from https://github.com/GoogleCloudPlatform/cloud-builders/blob/master/go/Dockerfile.alpine

# Install VCS tools to support "go get" commands and install gcc.
RUN apk add --update --no-cache git mercurial subversion build-base

# We blank out the GOPATH because the base image sets it, and
# if the user of this build step does *not* set it, we want to
# explore other options for workspace derivation.
ENV GOPATH=

RUN mkdir /builder

COPY go_workspace.go prepare_workspace.inc /builder/

COPY go.ash /builder/bin/
ENV PATH=/builder/bin:$PATH

RUN go build -o /builder/go_workspace /builder/go_workspace.go

# install tools
ENV PATH=$PATH:/root/go/bin
COPY install_tools.ash /builder/
RUN ash /builder/install_tools.ash

ENTRYPOINT ["go.ash"]
