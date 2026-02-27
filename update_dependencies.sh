#!/bin/bash

# Create a temporary directory for downloads
TEMP_DIR=$(mktemp -d)
cd "$TEMP_DIR"

# Download Hibernate and related dependencies
echo "Downloading Hibernate dependencies..."
curl -O https://repo1.maven.org/maven2/org/hibernate/hibernate-core/5.6.15.Final/hibernate-core-5.6.15.Final.jar
curl -O https://repo1.maven.org/maven2/org/hibernate/hibernate-commons-annotations/5.1.2.Final/hibernate-commons-annotations-5.1.2.Final.jar
curl -O https://repo1.maven.org/maven2/javax/persistence/javax.persistence-api/2.2/javax.persistence-api-2.2.jar
curl -O https://repo1.maven.org/maven2/org/antlr/antlr/2.7.7/antlr-2.7.7.jar
curl -O https://repo1.maven.org/maven2/cglib/cglib/3.3.0/cglib-3.3.0.jar
curl -O https://repo1.maven.org/maven2/commons-collections/commons-collections/3.2.2/commons-collections-3.2.2.jar
curl -O https://repo1.maven.org/maven2/org/dom4j/dom4j/2.1.3/dom4j-2.1.3.jar
curl -O https://repo1.maven.org/maven2/net/sf/ehcache/ehcache/2.10.9.2/ehcache-2.10.9.2.jar
curl -O https://repo1.maven.org/maven2/org/javassist/javassist/3.29.2-GA/javassist-3.29.2-GA.jar
curl -O https://repo1.maven.org/maven2/org/jboss/logging/jboss-logging/3.5.0.Final/jboss-logging-3.5.0.Final.jar
curl -O https://repo1.maven.org/maven2/org/jboss/spec/javax/transaction/jboss-transaction-api_1.2_spec/2.0.1.Final/jboss-transaction-api_1.2_spec-2.0.1.Final.jar

# Download logging dependencies
echo "Downloading logging dependencies..."
curl -O https://repo1.maven.org/maven2/org/slf4j/slf4j-api/2.0.7/slf4j-api-2.0.7.jar
curl -O https://repo1.maven.org/maven2/org/slf4j/slf4j-log4j12/2.0.7/slf4j-log4j12-2.0.7.jar
curl -O https://repo1.maven.org/maven2/log4j/log4j/1.2.17/log4j-1.2.17.jar

# Create lib directories in each project
echo "Creating lib directories..."
mkdir -p ../CRMFirstOn/lib
mkdir -p ../CRMHibernateCTR/lib
mkdir -p ../CRMFirstOnEval/lib

# Copy dependencies to each project
echo "Copying dependencies to projects..."
cp *.jar ../CRMFirstOn/lib/
cp *.jar ../CRMHibernateCTR/lib/
cp *.jar ../CRMFirstOnEval/lib/

# Download and install Tomcat 9
echo "Downloading Tomcat 9..."
curl -O https://dlcdn.apache.org/tomcat/tomcat-9/v9.0.85/bin/apache-tomcat-9.0.85.tar.gz
tar xzf apache-tomcat-9.0.85.tar.gz

# Copy Tomcat to a standard location
echo "Installing Tomcat 9..."
sudo mv apache-tomcat-9.0.85 /opt/tomcat9

# Clean up
cd ..
rm -rf "$TEMP_DIR"

echo "Dependencies have been updated successfully!"
echo "Please update your Eclipse workspace to use Tomcat 9.0.85" 