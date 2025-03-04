#!/bin/bash
yes | docker stop $(docker ps -a -q)
yes | docker rm $(docker ps -a -q)
yes | docker ps -a | awk '/py_test/ {print $1}' | xargs docker stop
yes | docker ps -a | awk '/py_test/ {print $1}' | xargs docker rm
yes | docker rmi $(docker images | awk '/^py_test/ {print $3}')
yes | docker system prune -f
yes | docker builder du
yes | docker builder prune -a
