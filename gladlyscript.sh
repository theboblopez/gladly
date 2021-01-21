#!/bin/bash
USERNAME="INSERT_EMAIL_HERE"
APITOKEN="INSERT_TOKEN_HERE"
CSVFILE="./sample-exercise.csv"
APIURL="https://psinterview.gladly.qa"
API="/api/v1/conversation-items"
IFS=$'\n'

for i in $(csvtojson $CSVFILE | sed '1d;$d')
do
x=$(echo $i | sed -e 's/"content":{/"content":{"type":"CUSTOMER_ACTIVITY","activityType":"EMAIL",/' | sed 's/,$//')
curl --write-out '%{http_code}\n' -u $USERNAME:$APITOKEN --header 'Content-Type: application/json' --request POST --data $x $APIURL$API
done
