#!/bin/bash

# List of CRM projects
PROJECTS=("CRMFirstOn" "CRMFirstOnWeb" "CRMFirstOnEval" "CRMHibernateCTR" "CRMHibernateControll" "CRMDB")

# Update each project's .classpath file
for project in "${PROJECTS[@]}"; do
    if [ -f "../$project/.classpath" ]; then
        echo "Updating Java version in $project..."
        # Create a backup
        cp "../$project/.classpath" "../$project/.classpath.bak"
        
        # Update Java version to 17
        sed -i '' 's/Java SE [0-9]\.[0-9]/Java SE 17/g' "../$project/.classpath"
        sed -i '' 's/JavaSE-[0-9]\.[0-9]/Java SE 17/g' "../$project/.classpath"
    fi
done

echo "Java version has been updated to 17 in all CRM projects."
echo "Please verify the changes in Eclipse and rebuild the projects." 