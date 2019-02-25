#!/bin/bash
source ./_vars.sh
# ================================================================
# Command-line Assistant - run.sh
# - Neo4j
# ================================================================


echo =============================================================
echo run.sh -a [action] -b [label] -c [container]
echo -------------------------------------------------------------
echo -a 01 : Docker: Build
echo -a 02 : Docker: Run Container
echo -a 03 : Docker: Stop Container
echo -a 04 : Docker: Remove all Containers
echo -a 05 : Docker: View Logs 
echo =============================================================

#Defaults
#ACTION="up"
LABEL="latest"
CONTAINER=myneo4jc
IMAGE=myneo4j
TARGET=prod

while getopts "a:b:c:t:" opt; do
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
  esac
done


case "$ACTION" in
  "01" )
    echo ===========================================================
    echo Docker Build
    echo ===========================================================
    docker build -t $IMAGE .
    ;;

  "02" )
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

  "03" )
    echo ===========================================================
    echo Docker Stop
    echo ===========================================================
    docker container stop $CONTAINER
    ;;

  "04" )
    echo ===========================================================
    echo Docker Remove Containers
    echo ===========================================================
    docker stop $(docker ps -aq)
    ;;

  "05" )
    echo ===========================================================
    echo Docker Logs
    echo ===========================================================
    docker logs -f $CONTAINER
    ;;

  * )
    # Default option.
    # Empty input (hitting RETURN) fits here, too.
    echo
    echo "Not a recognized option."
    ;;
esac





