# syntax=docker/dockerfile:1

# Build the application from source
FROM golang:1.22.0 AS build-stage

WORKDIR /app

COPY go.mod ./
RUN go mod download

COPY *.go ./

RUN CGO_ENABLED=0 GOOS=linux go build -o api server.go 

FROM build-stage AS run-test-stage
RUN go test -v ./...

FROM gcr.io/distroless/base-debian11 AS build-release-stage

WORKDIR /

COPY --from=build-stage /app/api /api

EXPOSE 8080

USER nonroot:nonroot

ENTRYPOINT ["/api"]