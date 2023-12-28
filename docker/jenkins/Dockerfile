FROM jenkins/jenkins:latest

USER root
RUN apt-get update && apt-get install -y apt-transport-https mc rsync subversion

RUN apt-get install -y git-ftp

COPY ./ssh/id_rsa /var/jenkins_home/.ssh/id_rsa
COPY ./ssh/id_rsa.pub /var/jenkins_home/.ssh/id_rsa.pub
COPY ./ssh/known_hosts /var/jenkins_home/.ssh/known_hosts

# chimmy churry keys to push via SSH 
COPY ./ssh/id_rsa_chimmychurry_m236 /var/jenkins_home/.ssh/id_rsa_chimmychurry_m236
COPY ./ssh/id_rsa_chimmychurry_m236.pub /var/jenkins_home/.ssh/id_rsa_chimmychurry_m236.pub
RUN chmod 777 /var/jenkins_home/.ssh/id_rsa_chimmychurry_m236 
RUN chmod 777 /var/jenkins_home/.ssh/id_rsa_chimmychurry_m236.pub

RUN chown jenkins:jenkins -R /var/jenkins_home/.ssh
RUN chmod 600 -R /var/jenkins_home/.ssh/id_rsa
RUN chmod 600 -R /var/jenkins_home/.ssh/id_rsa.pub
RUN chmod 777 -R /var/jenkins_home/.ssh/known_hosts

RUN chmod 777 /var/jenkins_home/.ssh/id_rsa_chimmychurry_m236 
RUN chmod 777 /var/jenkins_home/.ssh/id_rsa_chimmychurry_m236.pub

USER jenkins
#Disable wizard
ENV JAVA_OPTS -Djenkins.install.runSetupWizard=false

#config file for jenkis asCode
ENV CASC_JENKINS_CONFIG /usr/share/jenkins/ref/casc.yaml

#plugin for autoinstaling
COPY ./plugins.txt /usr/share/jenkins/ref/plugins.txt
RUN /usr/local/bin/install-plugins.sh < /usr/share/jenkins/ref/plugins.txt

COPY ./casc.yaml /usr/share/jenkins/ref/casc.yaml

# copy copia el job por default
COPY ./job-templates/chimmy.xml /usr/share/jenkins/ref/jobs/chimmy/config.xml