Created by : Rodrigo Luis Nolli Brossi 
16/08/2006
this release 1.0 of the hibernate implementation is part of a test to 
use it unless keep try make connections using JDBC
05/10/2010
Latest update of this file


<?xml version='1.0' encoding='utf-8'?>
<!DOCTYPE hibernate-configuration
    PUBLIC "-//Hibernate/Hibernate Configuration DTD//EN"
    "http://hibernate.sourceforge.net/hibernate-configuration-2.0.dtd">

<hibernate-configuration>
    <session-factory>
        <!--property name="connection.datasource">java:comp/env/jdbc/Medicamp</property-->
        <property name="hibernate.connection.driver_class">org.postgresql.Driver</property>
		<property name="hibernate.connection.url">jdbc:postgresql://127.0.0.1:5432/Brossi</property>
		<property name="hibernate.connection.username">postgres</property>
		<property name="hibernate.connection.password">jeca@2013</property>
        
        <property name="show_sql">false</property>        
        <property name="dialect">net.sf.hibernate.dialect.PostgreSQLDialect</property>
        <property name="hibernate.cglib.use_reflection_optimizer">true</property>
        <property name="hibernate.cache.provider_class">net.sf.ehcache.hibernate.Provider</property>
        <!-- <property name="hibernate.max_fetch_depth">3</property> profundidade -->
        <!-- Mapping files -->
        <property name="use_outer_join">true</property>
        <mappings>...
    </session-factory>
</hibernate-configuration>
