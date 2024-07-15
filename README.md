# Laravel development environment with docker
docker(alpine) = php-fpm + mariadb + redis + node

# …or repository from the command line
```shell
git clone https://github.com/nOo9ya/laravel-dev-env-with-docker.git

# or

git init
git remote add origin https://github.com/nOo9ya/laravel-dev-env-with-docker.git
git branch -M main
git add .
git commit -am "first init"
git push -u origin main

# or

git init --initial-branch=main
git remote add origin https://github.com/nOo9ya/laravel-dev-env-with-docker.git
git add .
git commit -am "first init"
git pull origin main
```


```shell
# 개발환경은 아래와 같이 실행하여 시작합니다.
docker-compose up --build --force-recreate

# docker cache 로 문제가 발생될 수 있으므로 아래와 같이 실행하여 캐시로 인한 문제를 회피하며 빌드
docker builder prune -af
docker-compose build --no-cache
```

## Laravel 파일이 없을 시 접근 후 설치
```shell
docker exec -it php /bin/sh
# laravel install 진행
# ex) 원하는 버전으로 설치
composer create-project laravel/laravel .(프로젝트명 .은 현재 경로에 그냥 설치) --prefer-dist 
"9.*"
# ex2) php 버전에 맞추어 최신 버전으로 설치
composer create-project laravel/laravel .
```

## node 개발 소스 설치가 완료 되었다면 다시 실행
```shell
docker compose down
docker compose up --build --force-recreate
```