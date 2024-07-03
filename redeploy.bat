rem "C:\xampp\catalina_stop.bat"
cd "C:\Users\Administrator\IdeaProjects\ECM4"
del C:\xampp\tomcat\webapps\ECM6.war
del C:\xampp\tomcat\webapps\ECM6\*.*
copy C:\Users\Administrator\IdeaProjects\ECM4\target\ECM4-1.0-SNAPSHOT.war C:\xampp\tomcat\webapps\ECM6.war
rem "C:\xampp\catalina_start.bat"
cd "C:\Users\Administrator\IdeaProjects\ECM4"