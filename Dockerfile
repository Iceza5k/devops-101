FROM node:18-alpine AS builder

WORKDIR /usr/src/app

COPY app/package*.json ./
RUN npm install --production --silent

COPY app/server.js ./

FROM gcr.io/distroless/nodejs18-debian12

WORKDIR /app
COPY --from=builder /usr/src/app ./

EXPOSE 3000
USER nonroot
CMD ["server.js"]
