FROM node:18-buster-slim

WORKDIR /app

COPY . .

RUN npm install

EXPOSE 443
CMD [ "node", "main.js" ]