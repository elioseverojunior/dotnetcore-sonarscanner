#!/bin/bash

BRANCH=$(git rev-parse --abbrev-ref HEAD)
if [[ "${BRANCH}" == "master" ]];
then
  TAG=latest
else
  TAG=${BRANCH}
fi

echo -en "Building container locally..."
docker build --rm -f "Dockerfile" -t elioseverojunior/dotnetcore-sonarscanner:${TAG} . 

echo -en "Pushing container locally..."
docker push elioseverojunior/dotnetcore-sonarscanner:${TAG}

