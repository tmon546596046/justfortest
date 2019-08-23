.PHONY: build push

IMAGE=justfortest
TAG=$(shell cat VERSION)


all: push

build:
	docker build --pull -t piranhahu/$(IMAGE):$(TAG) .

push: build
	docker login -u $GITHUB_USERNAME -p $GITHUB_PASSWORD
	docker push piranhahu/$(IMAGE):$(TAG)
