# Contao with Docker-Services

## Installation

Read complete blog entry at: https://xuad.net/artikel/contao-mittels-docker-container-einrichten

1. Create environments
```bash
mkdir ${HOME}/docker/data/certs -p && \
echo 'export DOCKER_ENV_CERT_PATH="${HOME}/docker/data/certs"' >> ${HOME}/.bashrc && \
echo 'export DOCKER_ENV_USER_ID="$(id -u)"' >> ${HOME}/.bashrc && \
echo 'export DOCKER_ENV_GROUP_ID="$(id -g)"' >> ${HOME}/.bashrc && \
exec bash
```

2. Create nginx-proxy network
```bash
docker network create nginx-proxy-network && \
cd nginx-proxy && \
docker-compose up -d
```

3. Build composer container
```bash
docker build build/composer-php-7.1 --build-arg PHP_USER_ID=${DOCKER_ENV_USER_ID} --build-arg PHP_GROUP_ID=${DOCKER_ENV_GROUP_ID} -t xuad/composer:7.1
```

4. Create ssl certs
```bash
openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
     -keyout ${DOCKER_ENV_CERT_PATH}/docker-contao.local.key \
     -out ${DOCKER_ENV_CERT_PATH}/docker-contao.local.crt \
     -subj "/C=DE/ST=Deutschland/L=Musterhausen/O=docker-contao.local/CN=docker-contao.local"
``` 

5. Start stack
```bash
docker-compose build && docker-compose up
```

6. Install contao
```bash
./composer.sh install
```
