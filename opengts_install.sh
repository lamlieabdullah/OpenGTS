  
#!/bin/bash
################################################################################
# https://stackoverflow.com/questions/29333424/gpsd-not-getting-a-good-fix
# https://askubuntu.com/questions/56104/how-can-i-install-sun-oracles-proprietary-java-jdk-6-7-8-or-jre
# http://www.opengts.org/
# https://www.linuxhelp.com/how-to-install-opengts-in-ubuntu
#  sudo apt-get remove --auto-remove openjdk*
# ./install
################################################################################

#Before installing the OpenGTS, update the system with the " apt-get update" command.
sudo apt-get update

#Next install the LAMP and unzip packages. Enter the root password for mysql while installing mysql server.
sudo apt-get install apache2 php mysql-server libmysql-java ant unzip
sudo /etc/init.d/mysql start

#Next install the openjdk by using the below given command.
#sudo apt-get install openjdk-8-jdk

#Use the below command to define the home environment for java.
export JAVA_HOME=/usr/lib/jvm/jdk1.8.0_281/
echo " export JAVA_HOME=/usr/lib/jvm/jdk1.8.0_281/"  >>  ~/.bashrc

#Now its time to install tomcat server with the below command.
#wget -c http://mirror.fibergrid.in/apache/tomcat/tomcat-8/v8.5.5/bin/apache-tomcat-8.5.5.zip
wget https://downloads.apache.org/tomcat/tomcat-8/v8.5.64/bin/apache-tomcat-8.5.64.zip

#Then extract the installed tomcat server.
unzip apache-tomcat-8.5.64.zip

#Here copy the extracted tomcat server directory to the respective location. Then set that location as the home directory path.
sudo cp -a apache-tomcat-8.5.64 /usr/local/
export CATALINA_HOME=/usr/local/apache-tomcat-8.5.64
cd /usr/local
sudo ln -s $CATALINA_HOME tomcat
cd $CATALINA_HOME/bin
chmod a+x *.sh
$CATALINA_HOME/bin/startup.sh
echo " export CATALINA_HOME=/usr/local/apache-tomcat-8.5.64"  >>  ~/.bashrc

#Then configure the java mail and java connector with the below command.
#wget -c http://dev.mysql.com/get/Downloads/Connector-J/mc-5.1.37.zip
cd /tmp
unzip mysql-connector-java-5.1.37.zip
sudo cp mysql-connector-java-5.1.37-bin.jar $JAVA_HOME/jre/lib/ext

cd /tmp/
wget -c https://maven.java.net/content/repositories/releases/com/sun/mail/javax.mail/1.5.2/javax.mail-1.5.2.jar
sudo cp javax.mail-1.5.2.jar $JAVA_HOME/jre/lib/ext/
sudo mv $JAVA_HOME/jre/lib/ext/javax.mail-1.5.2.jar $JAVA_HOME/jre/lib/ext/javax.mail.jar

#Now you need to Download and Configure the OpenGTS with the following command.
#wget -c http://liquidtelecom.dl.sourceforge.net/project/opengts/server-base/2.6.2/OpenGTS_2.6.2.zip
#wget -c http://gtse.us/gtsdl/OpenGTS_2.6.7.zip?t=1615813569&c=lamlie@hotmail.com&s=f8P_UOPEo70ant0qVXRAKTq2BvU=
sudo unzip /tmp/OpenGTS_2.6.7.zip -d /usr/local/
sudo chown -R odoo:odoo /usr/local/OpenGTS_2.6.7
export GTS_HOME=/usr/local/OpenGTS_2.6.7
echo " export GTS_HOME=/usr/local/OpenGTS_2.6.7"  >>  ~/.bashrc

#Next configure the environmental variables.
echo " export ANT_HOME=/usr/share/ant"  >>  ~/.bashrc
source ~/.bashrc
sudo ln -s $JAVA_HOME /usr/local/java
sudo ln -s $CATALINA_HOME /usr/local/tomcat
sudo ln -s $GTS_HOME /usr/local/gts

#Edit and open the Config.conf file with the below command.
#nano /usr/local/OpenGTS_2.6.7/config.conf

#While executing the above command, just uncomment the below lines
#Db.sql.user=gts
#Db.sql.password=opengts

#Save the file and exit. Verify that $CATALINA_HOME has a folder apache-tomcat.
#user1@linuxhelp:/tmp$  ls -l $CATALINA_HOME
#If recursive link is exist, then unlink it to avoid the compilation problem.
#user1@linuxhelp:/tmp$ unlink /usr/local/apache-tomcat-8.5.5/apache-tomcat-8.5.5

#Here you need to compile the OpenGTS.
cd $GTS_HOME

#Oee
#ant all

#Then initialize the OpenGTS with the below command.
#bin/initdb.sh -rootuser=root -rootPass=123

#Check whether everthing' s correct.
#bin/checkInstall.sh

#Now add account and install the Track Java Servlet.
#bin/admin.sh Account -account=sysadmin -pass=password -create
#cp build/track.war /usr/local/apache-tomcat-8.5.5/webapps/

#Restart the tomcat server for further process.
#$CATALINA_HOME/bin/shutdown.sh

#Remove the webapp track files with the below command.
##user1@linuxhelp:/usr/local/OpenGTS_2.6.2$ rm -rf /usr/local/apache-tomcat-8.5.5/webapps/track*
#user1@linuxhelp:/usr/local/OpenGTS_2.6.2$ cp $GTS_HOME/build/track.war $CATALINA_HOME/webapps/

#Again start the tomcat service by using the below command.
#user1@linuxhelp:/usr/local/OpenGTS_2.6.2$ $CATALINA_HOME/bin/startup.sh

#Finally run the below command to install the Event Java Servlet and gprmc package.
#/usr/local/OpenGTS_2.6.2$ ant events
#cp -v build/events.war $CATALINA_HOME/webapps
#ant gprmc
#cp build/gprmc.war /usr/local/apache-tomcat-8.5.5/webapps/

#Again verify the installation process.
#/usr/local/OpenGTS_2.6.2$ bin/checkInstall.sh

#localhost:8080/track/Track
#sysadmin/password



