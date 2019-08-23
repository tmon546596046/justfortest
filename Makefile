.PHONY: build push

IMAGE=justfortest
TAG=$(shell cat VERSION)


all: push

build:
        docker build --pull -t piranhahu/$(IMAGE):$(TAG) .

push: build
        docker push piranhahu/$(IMAGE):$(TAG)
