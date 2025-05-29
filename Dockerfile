FROM alpine/git:v2.47.2 AS fetcher
WORKDIR /usr/src/app
RUN git clone https://github.com/jackyzha0/quartz.git .

FROM node:24.1.0-slim AS builder
WORKDIR /usr/src/app
COPY --from=fetcher /usr/src/app /usr/src/app
RUN npm ci

FROM node:24.1.0-slim
WORKDIR /usr/src/app
COPY --from=builder /usr/src/app /usr/src/app
CMD ["npx", "quartz", "build", "--serve"]
