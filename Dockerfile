FROM golang:1.20rc1

ENV GOPATH /go/src

RUN mkdir /go/src/interpreter
WORKDIR /go/src/interpreter

COPY go.mod /go/src/interpreter/go.mod
COPY go.sum /go/src/interpreter/go.sum

RUN go mod download

RUN go install \ 
    github.com/cweill/gotests/gotests \
    github.com/fatih/gomodifytags \
    github.com/josharian/impl \
    github.com/haya14busa/goplay/cmd/goplay \
    github.com/go-delve/delve/cmd/dlv \
    honnef.co/go/tools/cmd/staticcheck \
    golang.org/x/tools/gopls

RUN apt update && \
    apt install -y \
        lsof cgroup-tools psmisc sudo vim \
        init systemd
