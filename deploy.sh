#!/bin/sh

MY_VERSION=$1; shift
DEMO_VERSION=0.0.1

[[ -z ${MY_VERSION//} ]] \
    || DEMO_VERSION=${MY_VERSION}

export DEMO_VERSION

rm -f *.yaml
rm -f Dockerfile

function exitfn {
	MSG=$1; shift
	echo >&2 ${MSG}
	exit 1
}

function exists_or_bail {
	COMMAND=$1; shift
	if type $COMMAND > /dev/null 2>&1
	then : OK
	else 
		exitfn "${COMMAND} is required."
	fi
}

function exists_or {
	COMMAND=$1; shift
	if type $COMMAND > /dev/null 2>&1
	then : OK
	else 
		echo >&2 "${COMMAND} is required."	
		return 1
	fi
	return 0
}

[[ -z ${RIFF_HOME} || ${RIFF_HOME} == .* ]] && exitfn "Set env \$RIFF_HOME to (absolute) root of local RIFF clone."

exists_or_bail minikube
exists_or_bail docker

PARENT=${USERNAME}
DELIM=""

function docker_detect {
    [[ -z ${DOCKER_HOST//} ]] && eval $(minikube docker-env)
}

# Single or Double namespace environment is assumed
[[ -z ${PARENT//} ]] && DELIM="/"

function docker_images {
    set -v
    docker_detect

    echo docker images --filter=reference="${PARENT}${DELIM}'*'"
}

# input image container name 
function docker_image_by_name {

    IMAGE_NAME=$1; shift

    docker_detect

    docker images --filter=reference=${PARENT}${DELIM}${IMAGE_NAME} --format "{{.ID}}"
}

# input image container name
function docker_rmi_by_name {

    IMAGE_NAME=$1; shift

    docker_detect

    docker rmi `docker_image_by_name ${IMAGE_NAME}`
}

set -a -e -v

[[ ${0} == *_nb.sh ]] || mvn clean package

PATH=$PATH:${RIFF_HOME}

exists_or_bail riff
eval $(minikube docker-env)

DEMO_JAR=target/demofn-${DEMO_VERSION}.jar

riff create --name demofn --input reverse-in\
    --protocol pipes --artifact ${DEMO_JAR}\
    --handler mcp.DemoFunction