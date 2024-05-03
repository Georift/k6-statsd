FROM grafana/xk6:0.11.0 as builder

RUN xk6 build v0.50.0 --with github.com/LeonAdato/xk6-output-statsd@v0.1.1

# Runtime stage
FROM alpine:3.18 as release

RUN adduser -D -u 12345 -g 12345 k6
COPY --from=builder /xk6/k6 /usr/bin/k6

USER k6
WORKDIR /home/k6

ENTRYPOINT ["k6"]
