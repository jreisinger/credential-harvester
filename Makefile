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
	docker build --build-arg GOOS=$(os) --build-arg GOARCH=$(arch) -t homepage-$(os)-$(arch) .

	# Push image to public registry - hub.docker.com
	docker login
	docker tag homepage-$(os)-$(arch):latest reisinge/homepage-$(os)-$(arch):latest
	docker push reisinge/homepage-$(os)-$(arch):latest
