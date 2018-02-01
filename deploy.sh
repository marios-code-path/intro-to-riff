#!/bin/sh

MY_VERSION=$1; shift
DEMO_VERSION=0.0.1

[[ -z ${MY_VERSION//} ]] \
    || DEMO_VERSION=${MY_VERSION}

export DEMO_VERSION

source ../bouncer.sh
source ../dockerfn.sh

set -a -e -v

[[ ${0} == *_nb.sh ]] || mvn clean package

PATH=$PATH:${RIFF_HOME}

exists_or_bail riff
eval $(minikube docker-env)

DEMO_JAR=target/demofn-${DEMO_VERSION}.jar

riff create --name democonsumer --input reverse-out\
    --protocol pipes --artifact ${DEMO_JAR}\
    --handler com.codepub.demo.DemoConsumer

riff create --name demofn --input reverse-in\
    --output reverse-out\
    --protocol pipes --artifact ${DEMO_JAR}\
    --handler com.codepub.demo.DemoFunction

riff create --name demosupplier --input supplier\
    --output reverse-in --protocol pipes\
    --artifact ${DEMO_JAR}\
    --handler com.codepub.demo.DemoSupplier