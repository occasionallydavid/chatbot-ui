include .env

IMAGE_NAME ?= chatbot-ui

.PHONY: all

build:
	docker build -t $(IMAGE_NAME) .

run:
	export $(cat .env | xargs)
	docker stop chatbot-ui || true && docker rm chatbot-ui || true
	docker run --name chatbot-ui --rm -e OPENAI_API_KEY=${OPENAI_API_KEY} -p 3000:3000 $(IMAGE_NAME)

logs:
	docker logs -f chatbot-ui

push: build
	docker push $(IMAGE_NAME)
