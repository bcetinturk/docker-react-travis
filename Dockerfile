## multi-step build

FROM node:alpine as builder
WORKDIR /app
COPY package.json .
RUN npm install
COPY . .
RUN npm run build

# /app/build <-- all the stuff we care about

# by ptting FROM we completed previous block
# and no need to have 'as ...', because we're not
# going to use it 
FROM nginx
COPY --from=builder /app/build /usr/share/nginx/html
