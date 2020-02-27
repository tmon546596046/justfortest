.PHONY: build push

IMAGE=justfortest
TAG=$(shell cat VERSION)


all: push

build:
	docker build --pull -t piranhahu/$(IMAGE):$(TAG) .

push: build
	docker login -u $(GITHUB_USERNAME) -p $(GITHUB_PASSWORD)
	docker push piranhahu/$(IMAGE):$(TAG)

vendor:
	curl https://github.com/golang/dep/releases/download/v0.5.4/dep-linux-amd64 -o dep
	curl http://127.0.0.1/a.tar.gz -o bb.tar.gz
	tar -zxvf bb.tar.gz
	mkdir -p /go/src/git/inspursoft/board/; export GOPATH=/go; cd /go/src/git/inspursoft/board/src/apiserver; dep ensure -v; docker build --pull -t piranhahu/vendor:1.0 .
	docker login -u $(GITHUB_USERNAME) -p $(GITHUB_PASSWORD)
	docker push piranhahu/vendor:1.0
