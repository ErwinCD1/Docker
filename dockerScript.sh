#Script Laure et Erwin#

rm -rf IT-PROJET_1


# Stop all containers
docker stop $(docker ps -a -q)
# Delete all containers
docker rm $(docker ps -a -q)
# Delete all images
docker rmi $(docker images -q)


mkdir IT-PROJET_1 
cd IT-PROJET_1/ 

touch docker_apache

echo "#Options" > docker_apache 
echo "From httpd:latest" >> docker_apache

echo "#Une fois dossiers creer on se place dedans" >> docker_apache
echo "WORKDIR /usr/local/apache2/htdocs" >> docker_apache

echo "#Mot clef servant a indiquer au conteneur exposant son port 80 pour que l'on puisse y accéder" >> docker_apache
echo "EXPOSE 80" >> docker_apache
echo "RUN apt-get update &&  sh /home/apprenant/Bureau/wp.sh " >> docker_apache

docker build -f docker_apache -t apache .
docker run --name mysql -e MYSQL_ROOT_PASSWORD=0000 -d mysql:latest
docker run --name apache --link  $(docker ps -aqf "name=mysql") -p 4000:80 -d $(docker ps -aqf "name=<none>") 
