FROM golang:1.23-bookworm AS builder
WORKDIR /app
COPY go.mod go.sum ./
RUN go mod download
COPY main.go parcel.go ./
RUN CGO_ENABLED=0 GOOS=linux go build -o /parcel-tracker .

FROM alpine:3.20
WORKDIR /app
COPY --from=builder /parcel-tracker /app/parcel-tracker
COPY tracker.db /app/tracker.db
CMD ["/app/parcel-tracker"]
