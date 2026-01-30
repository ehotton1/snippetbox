# syntax=docker/dockerfile:1

FROM golang:1.24.12-alpine AS build

WORKDIR /app

COPY go.mod ./
COPY go.sum ./
RUN go mod download

COPY cmd/ ./cmd/
COPY internal/ ./internal/
COPY ui/ ./ui/

RUN go build -o ./bin/web ./cmd/web

FROM gcr.io/distroless/base-debian12

WORKDIR /bin

COPY --from=build /app/bin/web /bin/web

USER nonroot:nonroot

ENTRYPOINT [ "/bin/web" ]