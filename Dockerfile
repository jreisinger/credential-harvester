FROM golang:1.13-alpine AS build

# Set the current working directory inside container.
WORKDIR /go/src/credential_harvester

# Build the app.
COPY . ./
RUN go build -o /bin/credential-harvester

# Create a single layer image.
#FROM scratch # -> this doesn't work
FROM alpine:latest
WORKDIR /app/credential_harvester
COPY --from=build /bin/credential_harvester /app/credential_harvester/credential-harvester

EXPOSE 8080
ENTRYPOINT ["/app/credential_harverster/credential-harvester"]