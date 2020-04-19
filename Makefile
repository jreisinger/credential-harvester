test:
	GO111MODULE=on go test ./...

build: test
	GO111MODULE=on go build main.go

PLATFORMS := linux/amd64

temp = $(subst /, ,$@)
os = $(word 1, $(temp))
arch = $(word 2, $(temp))

release: test $(PLATFORMS)

$(PLATFORMS):
	# Build multiplatform images
	docker build --build-arg GOOS=$(os) --build-arg GOARCH=$(arch) -t credential-harvester-$(os)-$(arch) .

	# Push image to public registry - hub.docker.com
	docker login
	docker tag credential-harvester-$(os)-$(arch):latest reisinge/credential-harvester-$(os)-$(arch):latest
	docker push reisinge/credential-harvester-$(os)-$(arch):latest
