FROM jenkins

USER root

# listing plugins from Jenkins console
#println 'pluginID:version'
#Jenkins.instance.pluginManager.plugins.each { plugin -> println ("${plugin.getShortName()}:${plugin.getVersion()}") }

COPY plugins.txt /usr/share/jenkins/ref/
RUN /usr/local/bin/install-plugins.sh `cat /usr/share/jenkins/ref/plugins.txt`

# Setting params. Git part is important because latest version of jenkins is trying to tag scm on every build and I couldn't find the knob to turn it off
RUN mkdir -p /usr/share/jenkins/ref/secrets/ \
    && echo "false" > /usr/share/jenkins/ref/secrets/slave-to-master-security-kill-switch \
    && git config --global user.email "jenkins@k8s" \
    && git config --global user.name "jenkins"