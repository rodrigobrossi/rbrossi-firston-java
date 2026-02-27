#!/bin/bash

# Install VSCode extensions
echo "Installing VSCode extensions..."
code --install-extension vscjava.vscode-java-pack
code --install-extension vscjava.vscode-maven
code --install-extension vscjava.vscode-tomcat

# Build the project
echo "Building the project..."
cd ..
mvn clean install

# Create Tomcat configuration
echo "Creating Tomcat configuration..."
mkdir -p .vscode
cat > .vscode/settings.json << EOL
{
    "java.configuration.updateBuildConfiguration": "automatic",
    "java.compile.nullAnalysis.mode": "automatic",
    "java.configuration.runtimes": [
        {
            "name": "JavaSE-17",
            "path": "/Library/Java/JavaVirtualMachines/jdk-17.jdk/Contents/Home",
            "default": true
        }
    ],
    "tomcat.installPath": "/usr/local/tomcat9",
    "tomcat.serverName": "Tomcat9",
    "tomcat.port": 8080
}
EOL

echo "Migration script completed!"
echo "Please follow these steps:"
echo "1. Open VSCode and open the project root directory"
echo "2. Wait for Java extension to finish setting up the project"
echo "3. Open the Maven panel and verify all modules are listed"
echo "4. In the Tomcat panel, click '+' to add a new server"
echo "5. Select the Tomcat installation directory"
echo "6. Right-click on the server and select 'Add War Package'"
echo "7. Select the WAR file from CRMFirstOnWeb/target/CRMFirstOnWeb-1.0-SNAPSHOT.war"
echo "8. Start the server and access the application at http://localhost:8080" 