
FROM golang:1.22.0 AS builder

WORKDIR /app

COPY go.mod go.sum ./
RUN go mod download

COPY . .

RUN CGO_ENABLED=0 GOOS=linux go build -o server .

FROM debian:bookworm-slim

WORKDIR /app

COPY --from=builder /app/server ./server
COPY --from=builder /app/tracker.db ./tracker.db

EXPOSE 3000

CMD ["./server"]
