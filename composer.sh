#!/bin/sh

docker run --rm -it \
	--user $(id -u):$(id -g) \
    --volume ${HOME}/.ssh/:/home/php-user/.ssh \
    --volume $(pwd)/source:/app \
    --volume $(pwd)/data/composer:/.composer xuad/composer:7.1 $*