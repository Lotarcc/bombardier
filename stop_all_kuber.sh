#!/bin/bash

RESOURCES_FILE="resources.txt"

echo "File: $RESOURCES_FILE"

IFS=$'\n' read -d '' -r -a lines < $RESOURCES_FILE

for i in "${lines[@]}"
do
   echo "$i"
   export URL=$i
   export REPLICAS=0
   export NAME=`echo $i| sed 's/\///g'|sed 's/://g'`
   envsubst < "bombardier.yaml" > "bombardier_dst.yaml"
   kubectl apply -f bombardier_dst.yaml -n ddos
done
