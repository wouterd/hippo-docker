Running locally
===============

This project uses the Maven Cargo plugin to run the CMS and site locally in Tomcat.
From the project root folder, execute:

  $ mvn clean install
  $ mvn -P cargo.run

Access the CMS at http://localhost:8080/cms, and the site at http://localhost:8080/site
Logs are located in target/tomcat6x/logs

Building distribution
=====================

To build a Tomcat distribution tarball containing only deployable artifacts:

  $ mvn clean install
  $ mvn -P dist

See also src/main/assembly/distribution.xml if you need to customize the distribution.

Using JRebel
============

Set the environment variable REBEL_HOME to the directory containing jrebel.jar.

Build with:

  $ mvn clean install -Djrebel

Start with:

  $ mvn -P cargo.run -Djrebel

Best Practice for development
=============================

Use the option -Drepo.path=/some/path/to/repository during start up. This will avoid
your repository to be cleared when you do a mvn clean.

For example start your project with:

$ mvn -P cargo.run -Drepo.path=/home/usr/tmp/repo

or with jrebel:

$ mvn -P cargo.run -Drepo.path=/home/usr/tmp/repo -Djrebel

Hot deploy
==========

To hot deploy, redeploy or undeploy the CMS or site:

  $ cd cms (or site)
  $ mvn cargo:redeploy (or cargo:undeploy, or cargo:deploy)

Automatic Export
================

To have your repository changes automatically exported to filesystem during local development, log into
http://localhost:8080/cms/console and press the "Enable Auto Export" button at the top right. To set this
as the default for your project edit the file
./bootstrap/configuration/src/main/resources/configuration/modules/autoexport-module.xml

Monitoring with JMX Console
===========================
You may run the following command:

  $ jconsole

Now open the local process org.apache.catalina.startup.Bootstrap start