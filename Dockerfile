FROM tomcat:8
# Take the war and copy to webapps of tomcat

RUN apt-get update
RUN apt-get -y install wget net-tools
COPY target/*.jar /usr/local/tomcat/webapps/
