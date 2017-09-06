#  Start working

To start this app, perform the following steps:

```bash
git clone https://github.com/VitaliiKulbachenko/docker-env-php.git
```

```bash
cd docker-env-php
```
- Create work directory

```bash
    mkdir -p {backup/mysql,mysql,logs}
```
- Install docker Ubuntu

```bash
sudo apt-key adv --keyserver hkp://p80.pool.sks-keyservers.net:80 --recv-keys 58118E89F3A912897C070ADBF76221572C52609D
sudo apt-add-repository 'deb https://apt.dockerproject.org/repo ubuntu-xenial main'
sudo apt-get update
apt-cache policy docker-engine
sudo apt-get install -y docker-engine
sudo usermod -aG docker $(whoami)
```

- Install docker-compose 

```bash
sudo -i
curl -L https://github.com/docker/compose/releases/download/1.16.0/docker-compose-`uname -s`-`uname -m` > /usr/local/bin/docker-compose
chmod +x /usr/local/bin/docker-compose
```

- Run docker-compose ./

```bash
    docker-compose up -d
```
```bash
   sudo -i
   echo "127.0.0.1 project.dev" >> /etc/hosts
```
 
https://github.com/Nchalenko/WebAcademy_MVC_BLOG.git
