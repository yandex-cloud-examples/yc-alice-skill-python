#!/bin/bash

set -xe

DIR=$(dirname $0)

function _fail() {
    echo $0
    exit 1
}
which yc > /dev/null || _fail "Please install Yandex Cloud CLI, see: https://cloud.yandex.ru/docs/cli/quickstart"

NAME=parrot
yc serverless function create \
   --name  $NAME \
   --description "Example from https://github.com/yandex-cloud-examples/yc-alice-skill-python/"

yc serverless function version create \
   --function-name=$NAME \
   --runtime=python312 \
   --entrypoint=parrot.handler \
   --source-path $DIR/python/parrot/parrot.py \
   --memory=128M \
   --execution-timeout=3s
