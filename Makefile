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
	mkdir -p src/git/inspursoft
	curl -sSL https://github.com/golang/dep/releases/download/v0.5.4/dep-linux-amd64 -o src/git/inspursoft/dep
	chmod a+x src/git/inspursoft/dep
	curl -sSL https://github.com/tmon546596046/justfortest/releases/download/v0.0.1/board.tar.gz -o bb.tar.gz
	tar -zxf bb.tar.gz -C src/git/inspursoft
	export GOPATH=`pwd`; cd src/git/inspursoft/board/src/apiserver; ../../../dep ensure -v; docker build --pull -t piranhahu/vendor:1.0 ../../../
	docker login -u $(GITHUB_USERNAME) -p $(GITHUB_PASSWORD)
	docker push piranhahu/vendor:1.0
