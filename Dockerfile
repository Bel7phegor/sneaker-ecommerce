## build stage ##
FROM node:18-alpine AS build
WORKDIR /app

COPY package*.json ./
RUN npm install --force

COPY . .

ARG REACT_APP_API_URL

ENV REACT_APP_API_URL=$REACT_APP_API_URL
RUN npm run build

## run stage ##
FROM nginx:alpine
COPY --from=build /app/build /usr/share/nginx/html

EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]

