#!/bin/bash
# ================================================================
# Command-line Assistant - run.sh
# - Neo4j
# ================================================================


echo =============================================================
echo Hi $USER@$HOSTNAME. 
echo What do you want to do?
echo -------------------------------------------------------------
echo 01 : Docker: Build
echo 02 : Docker: Run Container
echo 03 : Docker: Stop Container
echo 04 : Docker: View Logs 
echo ----------------------------------------------
echo qq : Exit [Quit]
echo Enter [Selection] to continue
echo =============================================================
# Command line selection
if [ -n "$1" ]; then
  SELECTION=$1
else
  read  -n 2 SELECTION
fi
if [ -n "$2" ]; then
  PARAM2=$2
else
  read  -n  PARAM2
fi
echo Your selection is : $SELECTION.
echo Your parameter is : $PARAM2.

IMAGE=myneo4j
CONTAINER=myneo4jc

case "$SELECTION" in
# Note variable is quoted.

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

#neo4j:3.0

  ;;


  "03" )
  echo ===========================================================
  echo Docker Stop
  echo ===========================================================
  docker container stop $CONTAINER
  ;;



  "04" )
  echo ===========================================================
  echo Docker Logs
  echo ===========================================================
  docker logs $CONTAINER
  ;;


  "qq" )
  echo Quit
  exit 0
  ;;

   * )
   # Default option.
   # Empty input (hitting RETURN) fits here, too.
   echo
   echo "Not a recognized option."
  ;;

esac


