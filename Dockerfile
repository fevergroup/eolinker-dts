FROM node:10-alpine

ENV NODE_ENV=production

WORKDIR /tmp/pkg
COPY pkg-deps.json /tmp/pkg/package.json
RUN npm i 

COPY npm-pack.tgz /tmp/npm-pack.tgz
RUN set -x \
  && tar -xzf /tmp/npm-pack.tgz -C /tmp \
  && mv /tmp/package /app \
  && mv /tmp/pkg/node_modules /app \
  && rm -rf /tmp/npm-pack.tgz /tmp/pkg $(npm config get cache)

WORKDIR /app

CMD [ "npm", "start" ]