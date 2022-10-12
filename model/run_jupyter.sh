#!/bin/bash/

LINK="http://127.0.0.1:8888/?token=07fa3d7708ad88ca85fb4d0a7dd90bf32480d42825393f62"

(curl --silent --retry 20 --retry-delay 1 --retry-connrefused \
       http://127.0.0.1:8888 ; \
     start $LINK) &
docker start -i food_predict_model

docker stop food_predict_model