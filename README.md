Copied from https://github.com/blackhat-go/bhg/tree/master/ch-4/credential_harvester.

## Usage

## Development

Initialize the project

```
# Let's use Go modules for dependency management.
go mod init github.com/jreisinger/credential-harvester
```

Test locally:

```
make build
./main

curl localhost:8080
```

Release to dockerhub:

```
make release
```
