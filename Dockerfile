FROM openshift/jenkins-agent-base
ENV __doozer=update BUILD_RELEASE=202210061437.p0.g421f1f9.assembly.stream BUILD_VERSION=v4.10.0 OS_GIT_MAJOR=4 OS_GIT_MINOR=10 OS_GIT_PATCH=0 OS_GIT_TREE_STATE=clean OS_GIT_VERSION=4.10.0-202210061437.p0.g421f1f9.assembly.stream SOURCE_GIT_TREE_STATE=clean
ENV __doozer=merge OS_GIT_COMMIT=421f1f9 OS_GIT_VERSION=4.10.0-202210061437.p0.g421f1f9.assembly.stream-421f1f9 SOURCE_DATE_EPOCH=1664379082 SOURCE_GIT_COMMIT=421f1f9f1f0a95e0acf63a16b1ad5cbcc0cf234f SOURCE_GIT_TAG=421f1f9f SOURCE_GIT_URL=https://github.com/openshift/jenkins

MAINTAINER OpenShift Developer Services <openshift-dev-services+jenkins@redhat.com>

# Labels consumed by Red Hat build service

ENV NODEJS_VERSION=14 \
    NPM_CONFIG_PREFIX=$HOME/.npm-global \
    PATH=$HOME/node_modules/.bin/:$HOME/.npm-global/bin/:$PATH \
    LANG=en_US.UTF-8 \
    LC_ALL=en_US.UTF-8

# Install NodeJS
RUN INSTALL_PKGS="nodejs nodejs-nodemon make gcc-c++" && \
    yum module enable -y nodejs:${NODEJS_VERSION} && \
    yum install -y --setopt=tsflags=nodocs --disableplugin=subscription-manager $INSTALL_PKGS && \
    rpm -V $INSTALL_PKGS && \
    yum clean all -y

RUN chown -R 1001:0 $HOME && \
    chmod -R g+rw $HOME

USER 1001

LABEL \
        com.redhat.component="ose-jenkins-agent-nodejs-12-container" \
        name="openshift/ose-jenkins-agent-nodejs" \
        architecture="x86_64" \
        io.k8s.display-name="Jenkins Agent Nodejs" \
        io.k8s.description="The jenkins agent nodejs image has the nodejs tools on top of the jenkins agent base image." \
        io.openshift.tags="openshift,jenkins,agent,nodejs" \
        maintainer="openshift-dev-services+jenkins@redhat.com" \
        License="GPLv2+" \
        vendor="Red Hat" \
        io.openshift.maintainer.product="OpenShift Container Platform" \
        io.openshift.maintainer.component="Jenkins" \
        release="202210061437.p0.g421f1f9.assembly.stream" \
        io.openshift.build.commit.id="421f1f9f1f0a95e0acf63a16b1ad5cbcc0cf234f" \
        io.openshift.build.source-location="https://github.com/openshift/jenkins" \
        io.openshift.build.commit.url="https://github.com/openshift/jenkins/commit/421f1f9f1f0a95e0acf63a16b1ad5cbcc0cf234f" \
        version="v4.10.0"
