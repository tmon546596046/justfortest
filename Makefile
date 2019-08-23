.PHONY: build push

IMAGE=kube-cross
TAG=$(shell cat VERSION)


all: push

build:
        docker build --pull -t staging-k8s.gcr.io/$(IMAGE):$(TAG) .

push: build
        docker push staging-k8s.gcr.io/$(IMAGE):$(TAG)
