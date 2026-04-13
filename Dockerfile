FROM node:20

WORKDIR /app

COPY package*.json ./
RUN npm install

COPY . .

ENV TZ=UTC

CMD ["sh", "-c", "\
while true; do \
  echo \"Running tests at $(date -u)\"; \
  npm run test aggregators 3route $(date -u +%F); \
  sleep $((300 - $(date -u +%s) % 300)); \
done"]