develop: build
	docker run -it --rm \
	-v $(shell pwd):$(shell pwd) \
	-w $(shell pwd) \
	-p 8070:3000 \
	myip sh
build:
	docker build -t myip .
