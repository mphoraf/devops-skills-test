#!/bin/bash
export DVERSION="19.03.13"

dockerInstall() {
  curl -sL "ttps://download.docker.com/linux/static/stable/$(uname -m)/docker-$DVERSION.tgz" -o /tmp/docker-$DVERSION.tgz
  tar xzf /tmp/docker-$DVERSION.tgz -C /tmp
  sudo cp /tmp/docker/* /usr/local/bin/
  rm -f /tmp/docker-$DVERSION.tgz
}

isDocker() {
if [ ! `which docker` ];
then
  echo -e "Docker is not installed ...\nrunning docker install..."
  dockerInstall
else
  CurDocker=$(docker version | grep -A2 Server| awk '/Version/ {print $2}')
  if [ "$CurDocker" != "$DVERSION" ]; then
    echo -e "The current docker version needs to be updated\nRunning docker update..."
    dockerInstall
  fi
fi 2>/dev/null
}

startContainer() {
  for FUNC in `echo stop rm`; do
    echo "$FUNC the container."
    sh "docker container $FUNC  $(docker ps -a --filter name=ALFRED -q)"
  done 2>/dev/null
  echo "Restarting the container."
  docker build -t local/mymaria .
  docker run -d --name ALFRED -e MYSQL_ALLOW_EMPTY_PASSWORD=yes -v /var/lib/mysql:/var/lib/mysql -v /BATCAVE:/BATCAVE local/mymaria
}

execCommands() {
  docker exec ALFRED mysql -u root -e "create database wayneindustries;" 
  docker exec ALFRED mysql -u root -D wayneindustries -e "create table fox (ID integer(5) primary key, NAME varchar(30));" 
  docker exec ALFRED mysql -u root -D wayneindustries -e "INSERT INTO fox (ID, NAME) VALUES(50,'BATMOBILE');" 
}

isDocker
startContainer
execCommands
