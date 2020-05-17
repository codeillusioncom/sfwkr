#!/bin/bash
REGISTRY=dockerhub.com
MYUSER=codeillusioncom
APP=sfwkr
VERSION=$(cat VERSION)

echo "Building $VERSION..."
docker build -t $MYUSER/$APP:$VERSION .
echo "Tagging $VERSION..."
docker tag $MYUSER/$APP:$VERSION $MYUSER/$APP:$VERSION
echo "Logging in..."
docker login $REGISTRY
echo "Pushing $VERSION..."
docker push $MYUSER/$APP:$VERSION
echo "DONE!"
