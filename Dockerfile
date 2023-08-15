# Builder Stage (빌드 파일 생성)
FROM node:alpine as builder

WORKDIR /usr/src/app

COPY package.json ./

RUN npm install

COPY ./ ./

#CMD ["RUN", "npm", "build"]
RUN npm run build

# Run stage (Nginx가 빌더 파일을 구동시키는 부분)
# nginx를 위한 베이스 이미지
FROM nginx 

# Builder Stage에서 생성한 파일은 /usr/src/app/build 에 생성되며, 이 경로에 저장된 파일들을 /usr/share/nginx/html로 복사. 
# 브라우저에서 HTTP 요청이 올 때마다 Nginx가 알맞은 파일을 전달할 수 있게 만듦.
# 클라이언트의 요청이 들어올 때마다 Nginx가 알맞은 정적 파일을 제공하기 위해 /usr/share/nginx/html 장소로 빌드된 파일을 복사. 
COPY --from=builder /usr/src/app/build /usr/share/nginx/html