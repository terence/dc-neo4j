#!/bin/bash
source ./_vars.sh
# ================================================================
# Command-line Assistant - run.sh
# ================================================================


echo =============================================================
echo run.sh -a [action] -b [label] -c [container]
echo -------------------------------------------------------------
echo -a build : Docker: Build
echo -a start : Docker: Run Container
echo -a stop : Docker: Stop Container
echo -a remove : Docker: Kill & Remove a Containers
echo -a killall : Docker: Kill all Containers
echo -a logs : Docker: View Logs 
echo =============================================================

#Defaults
#ACTION="up"
LABEL="latest"
CONTAINER=myneo4jc
IMAGE=myneo4j
TARGET=prod
SCRIPT=dev.yml

while getopts "a:b:c:t:s:" opt; do
  case "${opt}" in 
    "a" )
      ACTION="${OPTARG}"
      echo "Action:" $ACTION
      ;;
    "b" )
      LABEL="${OPTARG}"
      echo "Label:" $LABEL
      ;;

    "c" )
      CONTAINER="${OPTARG}"
      echo "Container:" $CONTAINER
      ;;

    "t" )
      TARGET="${OPTARG}"
      echo "Target:" $TARGET
      ;;
    "s" )
      SCRIPT="${OPTARG}"
      echo "Script:" $SCRIPT
      ;;
  esac
done

export LABEL="{$LABEL}"
# export DATA_DIR="${HOME}/ga/${LABEL}


case "$ACTION" in
  "build" )
    echo ===========================================================
    echo Docker Build
    echo ===========================================================
    docker build -t $IMAGE .
    ;;

  "start" )
    echo ===========================================================
    echo Docker Run
    echo ===========================================================
    docker run \
    --name $CONTAINER \
    --publish=7474:7474 --publish=7687:7687 \
    --volume=$HOME/neo4j/data:/data \
    --volume=$HOME/neo4j/logs:/logs \
    -d \
    $IMAGE \
    ;;

  "stop" )
    echo ===========================================================
    echo Docker Stop
    echo ===========================================================
    docker container stop $CONTAINER
    ;;

  "remove" )
    echo ===========================================================
    echo Docker Remove Containers
    echo ===========================================================
    docker kill $CONTAINER
    docker rm -f $CONTAINER
#    docker stop $(docker ps -aq)
    ;;


  "killall" )
    echo ===========================================================
    echo Docker Remove All Containers
    echo ===========================================================
    docker stop $(docker ps -aq)
    ;;




  "logs" )
    echo ===========================================================
    echo Docker Logs
    echo ===========================================================
    docker logs -f $CONTAINER
    ;;


  "compose" )
    echo ===========================================================
    echo Docker Compose
    echo ===========================================================
    docker-compose -f $SCRIPT
    ;;


  * )
    # Default option.
    # Empty input (hitting RETURN) fits here, too.
    echo
    echo "Not a recognized option."
    ;;
esac





