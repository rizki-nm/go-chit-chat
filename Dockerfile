FROM golang:1.21 as builder
WORKDIR /app

COPY go.mod go.sum ./
RUN go mod download

COPY . .
RUN CGO_ENABLED=0 go build -o binary ./cmd/main.go

FROM alpine:3
RUN apk update && apk add --no-cache ca-certificates tzdata && update-ca-certif>
COPY --from=builder /app/binary .
