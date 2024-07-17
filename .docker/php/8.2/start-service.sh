#!/bin/sh

set -e

crond

if [ -f "${WORK_DIR}/artisan" ]; then

  if [ -f "${WORK_DIR}/public/storage" ]; then
    unlink ${WORK_DIR}/public/storage
    ln -s ${WORK_DIR}/storage/app/public/ ${WORK_DIR}/public/storage
  fi

#  if [ ! -d "${WORK_DIR}/public/storage" ]; then
#    php artisan storage:link
#  fi


  if [ "prod" = "$APP_ENV" ]; then
    echo ">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>"
    echo ">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> production php service container start"
    echo ">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>"
    composer install --optimize-autoloader --no-dev
    php artisan config:clear
    php artisan route:clear
    php artisan view:clear
    php artisan event:clear

    php artisan config:cache
    php artisan route:cache
    php artisan view:cache
    php artisan event:cache
  else
    echo "@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@"
    echo "@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@ develop php service container start"
    echo "@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@"
    composer install && composer dump-autoload
#    php artisan cache:clear
#    php artisan optimize:clear # cache 도 clear 해버림
  fi

#  composer cc
  composer clear-cache

#  -------------- migrate start
#  php artisan migrate

#  ------------- Crontab Update
  echo "*       *       *       *       *       /usr/local/bin/php ${WORK_DIR}/artisan schedule:run >> /var/log/cron.log 2>&1" >> /var/spool/cron/crontabs/root;
  echo "30      4       *       *       6       rm /var/log/cron.log" >> /var/spool/cron/crontabs/root;
  echo "30      4       *       *       *       find ${WORK_DIR}/storage/logs/ -name '*.log' -mtime +30 -delete" >> /var/spool/cron/crontabs/root;
  echo "30      4       *       *       *       find ${WORK_DIR}/storage/debugbar/ -name '*.json' -mtime +30 -delete" >> /var/spool/cron/crontabs/root;
  echo "30      4       *       *       *       find /var/log/laravel/ -name '*.log' -mtime +30 -delete" >> /var/spool/cron/crontabs/root;
  echo "30      4       *       *       *       find /var/log/supervisor/ -name '*.log' -mtime +30 -delete" >> /var/spool/cron/crontabs/root;
  echo "=============================================================================================="
  echo "============================= already server php service container ============================="
  echo "=============================================================================================="
else
  echo "not found artisan file!!!!!!!"
  echo "You must have Laravel installed"
  tail -f /dev/null
fi

tail -f /dev/null