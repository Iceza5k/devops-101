FROM node:20-alpine

WORKDIR /usr/src/app

COPY app/package.json ./
COPY app/server.js ./

EXPOSE 3000

CMD ["node", "server.js"]
