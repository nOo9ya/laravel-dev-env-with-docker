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
docker exec -it php8.2 /bin/sh
# laravel install 진행
# ex) 원하는 버전으로 설치
composer create-project laravel/laravel .(프로젝트명 .은 현재 경로에 그냥 설치) --prefer-dist 
"9.*"
# ex2) php 버전에 맞추어 최신 버전으로 설치
composer create-project laravel/laravel .
```

## laravel 서버 실행
```shell
docker exec -it php8.2 /bin/sh

# laravel serve option in docker
php artisan serve --host=0.0.0.0 --port=80
```

## node 개발 소스 설치가 완료 되었다면 다시 실행
```shell
docker compose down
docker compose up --build --force-recreate
```

# Xdebug 사용 시 설정
### vscode
vscode 사용시 .vscode/launch.json 에 추가
1. 왼쪽 사이드바에서 "Run and Debug" 아이콘을 클릭합니다.
2. "Listen for Xdebug" 설정을 선택합니다.
3. "Start Debugging" 버튼을 클릭하거나 F5를 누릅니다.
```json
{
    "version": "0.2.0",
    "configurations": [
        {
            "name": "Listen for Xdebug",
            "type": "php",
            "request": "launch",
            "port": 9003,
            "pathMappings": {
                "/var/www": "${workspaceFolder}/src"
            }
        }
    ]
}
```

### IntelliJ
A. PHP 인터프리터 설정:
1. File > Settings (Windows/Linux) 또는 IntelliJ IDEA > Preferences (macOS)로 이동
2. Languages & Frameworks > PHP로 이동
3. CLI Interpreter 옆의 '...' 버튼 클릭
4. '+' 버튼을 클릭하고 'From Docker, Vagrant, VM, Remote...' 선택
5. 'Docker Compose' 선택 후 서비스에서 'php' 선택
6. 'OK' 클릭하여 설정 저장

B. 서버 구성:
1. File > Settings (Windows/Linux) 또는 IntelliJ IDEA > Preferences (macOS)로 이동
2. Languages & Frameworks > PHP > Servers로 이동
3. '+' 버튼을 클릭하여 새 서버 추가
4. 이름을 'Docker-php'로 설정 (PHP_IDE_CONFIG의 serverName과 일치해야 함)
5. Host를 'localhost'로 설정
6. 'Use path mappings' 체크박스 선택
7. 프로젝트 루트 디렉토리를 '/var/www/'에 매핑

C. Run/Debug 구성:
1. Run > Edit Configurations 메뉴 선택
2. '+' 버튼 클릭 후 'PHP Remote Debug' 선택
3. 이름 설정 (예: 'Docker PHP Debug')
4. 서버를 앞서 생성한 'Docker-php'로 선택
5. IDE key를 'INTELLIJ'로 설정 (xdebug.ini의 idekey와 일치)


#### IntelliJ IDEA에서 디버깅을 시작하려면:
1. 설정한 'Docker Debug' 구성을 선택합니다.
2. 'Debug' 버튼을 클릭하거나 Shift+F9를 누릅니다.
3. 코드에 중단점을 설정하고 애플리케이션을 실행합니다.
