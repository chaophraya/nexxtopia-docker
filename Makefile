team=nexxt
image=nexxtopia
version=0.1.0
prefix=org.chaophraya/$(team)
tag=$(prefix)/$(image):$(version)

dist/scm-source.json:
	@sh ./create-scm-source.sh

build: dist/scm-source.json
	docker build -t $(tag) .

start-test: stop-test build
	docker run -p 4873:4873 --name sinopia-test -v /home/docker/sinopia-test:/opt/sinopia/storage $(tag)
	docker logs sinopia-test

stop-test:
	-docker rm -f sinopia-test 2>&1 > /dev/null

test: build
	docker run --rm -i -t $(tag)

shell: build
	docker run --rm -i -t $(tag) /bin/bash

logs:
	docker logs sinopia-test

publish:
	docker push $(tag)
