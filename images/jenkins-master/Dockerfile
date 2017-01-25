FROM jenkins

USER root

# listing plugins from Jenkins console
#println 'pluginID:version'
#Jenkins.instance.pluginManager.plugins.each { plugin -> println ("${plugin.getShortName()}:${plugin.getVersion()}") }

COPY plugins.txt /usr/share/jenkins/ref/
RUN /usr/local/bin/install-plugins.sh `cat /usr/share/jenkins/ref/plugins.txt`
RUN mkdir -p /usr/share/jenkins/ref/secrets/ \
    && echo "false" > /usr/share/jenkins/ref/secrets/slave-to-master-security-kill-switch