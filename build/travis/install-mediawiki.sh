#!/bin/bash
set -ex

cd ..

wget https://github.com/wikimedia/mediawiki/archive/$MW.tar.gz
tar -zxf $MW.tar.gz
mv mediawiki-$MW mw

cd mw

## MW 1.25 requires Psr\Logger
if [ -f composer.json ]
then
  composer install
fi

mysql -e 'create database its_a_mw;'
php maintenance/install.php --dbtype mysql --dbuser root --dbname its_a_mw --dbpath $(pwd) --pass AdminPassword TravisWiki admin --scriptpath /TravisWiki