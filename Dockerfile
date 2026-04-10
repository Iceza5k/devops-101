FROM node:22-alpine

WORKDIR /usr/src/app

RUN apk update && apk upgrade --no-cache

RUN rm -rf /usr/local/lib/node_modules/npm /usr/local/bin/npm

ENV NODE_ENV=production

COPY /app/package.json /app/server.js ./

USER node

EXPOSE 3000

CMD ["node", "server.js"]