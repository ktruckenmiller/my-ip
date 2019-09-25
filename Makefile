develop: build
	docker run -it --rm \
	-v $(shell pwd):$(shell pwd) \
	-w $(shell pwd) \
	-p 8070:3000 \
	myip sh
build:
	docker build -t myip .

run: build
	docker run -it --rm \
	-v $(shell pwd):$(shell pwd) \
	-w $(shell pwd) \
	-p 8070:3000 \
	myip

deploy:
	docker run -it --rm \
	-e IAM_ROLE \
	-v $(shell pwd):/work \
	-w /work \
	ktruckenmiller/ansible \
	ansible-playbook -i ansible_connection=localhost deploy.yml -vvv

put-pipeline:
	docker run -it --rm \
	-e IAM_ROLE \
	-v ${PWD}:/work \
	-w /work \
	ktruckenmiller/ansible \
	ansible-playbook -i ansible_connection=localhost deploy-pipeline.yml
