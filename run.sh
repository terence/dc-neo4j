#!/bin/bash
source ./_vars.sh
# ================================================================
# Command-line Assistant - run.sh
# - Neo4j
# ================================================================


echo =============================================================
echo run.sh -a [action] -b [label] -c [container]
echo -------------------------------------------------------------
echo -a build : Docker: Build
echo -a run : Docker: Run Container
echo -a stop : Docker: Stop Container
echo -a kill : Docker: Remove all Containers
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


case "$ACTION" in
  "build" )
    echo ===========================================================
    echo Docker Build
    echo ===========================================================
    docker build -t $IMAGE .
    ;;

  "run" )
    echo ===========================================================
    echo Docker Run
    echo ===========================================================
    docker run -d \
    --publish=7474:7474 --publish=7687:7687 \
    --volume=$HOME/neo4j/data:/data \
    --volume=$HOME/neo4j/logs:/logs \
    $IMAGE \
#    --name $CONTAINER \
    ;;

  "stop" )
    echo ===========================================================
    echo Docker Stop
    echo ===========================================================
    docker container stop $CONTAINER
    ;;

  "remove" )
    echo ===========================================================
    echo Docker Remove All Containers
    echo ===========================================================
    docker kill $CONTAINER
    docker rm -f $CONTAINER
#    docker stop $(docker ps -aq)
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





