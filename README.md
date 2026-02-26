# FIRSTON Java

## Description

A legacy Java Enterprise workspace containing multiple Eclipse projects demonstrating enterprise application patterns with IBM WebSphere, JMS messaging, Dojo AJAX, and a CRM-style application. Includes Hibernate/PostgreSQL persistence, Wicket UI components, and a Smart Rwanda Dashboard sample.

## Projects

| Project | Description |
|---------|-------------|
| `Bookstore` | Web application example |
| `FirstOnControl` | Enterprise Java control layer |
| `FirstOnBar` / `FirstOnBarApplets` | Java Applet UI components |
| `RGBBookStore` / `RGBBookStoreEAR` | RGB-themed bookstore EAR application |
| `JMS_Test` / `JMSTestWebApp` | JMS messaging test applications |
| `DojoAjax` | Dojo framework AJAX samples |
| `SmartRwandaDashboard*` | Publisher/Subscriber dashboard samples |
| `Wicket` | Apache Wicket UI framework sample |
| `ApplicationTest` | Test project |
| `crm-projects` | CRM application module |

## Prerequisites

- Java 8 (JDK)
- Eclipse IDE for Java EE Developers
- Apache Maven 3.x
- PostgreSQL (for Hibernate/CRM modules)
- IBM WebSphere Application Server or Apache Tomcat (for EAR/WAR deployments)

## Configuration

### Database (Hibernate / CRM)

Update `CRMDB.properties` with your PostgreSQL connection details:

```properties
# Example connection properties
db.url=jdbc:postgresql://localhost:5432/crmdb
db.username=your_user
db.password=your_password
```

Hibernate settings are typically found in each project's `persistence.xml` or `hibernate.cfg.xml`.

### Maven Dependencies

Run the provided scripts to set up local dependencies before importing into Eclipse:

```bash
# Download required dependencies
bash download_deps.sh

# Install extensions
bash install_extensions.sh

# Update dependencies to a specific Java version
bash update_java_version.sh
```

## How to Run

### Import into Eclipse

1. Open Eclipse IDE for Java EE Developers.
2. Go to **File > Import > Existing Projects into Workspace**.
3. Select this repository's root directory.
4. Select all projects you wish to import and click **Finish**.
5. Right-click on the target project > **Run As > Run on Server**.

### Build with Maven

From the repository root:

```bash
mvn clean install
```

To build a specific module:

```bash
mvn clean package -pl Bookstore
```

### Deploy

- **WAR files**: Deploy to Tomcat or WebSphere via the server console or `autodeploy` folder.
- **EAR files**: Deploy `RGBBookStoreEAR` or `TestEAR` to WebSphere Application Server.

## Notes

- This is a legacy workspace originally developed for IBM training purposes.
- The `crm-projects` directory contains a more modern Maven-structured CRM module.
- Hibernate 5.6 / PostgreSQL 42.6 are used in the `crm-projects` submodule.
- The `C:` directory is an artifact from a Windows-origin workspace — it can be ignored on macOS/Linux.
