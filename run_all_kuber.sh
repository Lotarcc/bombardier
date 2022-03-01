#!/bin/bash
RESOURCES_FILE="resources.txt"

echo "File: $RESOURCES_FILE"

IFS=$'\n' read -d '' -r -a lines < $RESOURCES_FILE

for i in "${lines[@]}"
do
   echo "$i"
   export REPLICAS=25
   export URL=$i
   export NAME=`echo $i| sed 's/\///g'|sed 's/://g'`
   envsubst < "bombardier.yaml" > "bombardier_dst.yaml"
   kubectl apply -f bombardier_dst.yaml
done
