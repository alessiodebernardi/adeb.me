HUGO_IMAGE := klakegg/hugo:0.107.0

build:
	docker run --rm -it \
		-v $(shell pwd):/src \
		$(HUGO_IMAGE)

server:
	docker run --rm -it \
		-v $(shell pwd):/src \
		-p 1313:1313 \
		$(HUGO_IMAGE) \
		server --buildDrafts