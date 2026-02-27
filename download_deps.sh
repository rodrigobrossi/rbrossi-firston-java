#!/bin/bash

# Create directories for dependencies
mkdir -p lib/hibernate
mkdir -p lib/logging
mkdir -p lib/tomcat

# Download Tomcat 9
echo "Downloading Tomcat 9..."
curl -L -o lib/tomcat/apache-tomcat-9.0.85.tar.gz https://dlcdn.apache.org/tomcat/tomcat-9/v9.0.85/bin/apache-tomcat-9.0.85.tar.gz
cd lib/tomcat
tar xzf apache-tomcat-9.0.85.tar.gz
cd ../..

# Use Maven to download dependencies
echo "Downloading dependencies using Maven..."
mvn clean package

# Copy dependencies to project lib directories
echo "Copying dependencies to project directories..."
for project in CRMFirstOn CRMHibernateCTR CRMFirstOnEval; do
    mkdir -p ../$project/lib
    cp target/lib/*.jar ../$project/lib/
done

echo "Dependencies have been downloaded and organized successfully!"
echo "Next steps:"
echo "1. Update your Eclipse workspace to use Tomcat 9.0.85"
echo "2. Update project Java compiler settings to Java 17"
echo "3. Clean and rebuild all projects" 