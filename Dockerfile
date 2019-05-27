FROM tomcat:8
# Take the war and copy to webapps of tomcat

RUN yum -y upgrade
RUN yum -y install wget net-tools
COPY target/*.jar /usr/local/tomcat/webapps/
