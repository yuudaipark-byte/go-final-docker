
FROM golang:1.23-bookworm AS builder

WORKDIR /app

COPY . .

RUN go mod tidy

RUN CGO_ENABLED=0 GOOS=linux go build -o server .

FROM debian:bookworm-slim

WORKDIR /app

COPY --from=builder /app/server ./server
COPY --from=builder /app/tracker.db ./tracker.db

EXPOSE 3000

CMD ["./server"]
