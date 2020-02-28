#!/bin/bash
#set -e

if [[ -z "$1" ]]
then
  echo "Operator repository missing. Please specify a repository to push to and pull from for testing purposes. example: ./run.sh images.example.com/test-operator:v1"
  exit 2
fi

kubectl create secret generic dockerauth --from-file=.dockerconfigjson=$HOME/.docker/config.json --type=kubernetes.io/dockerconfigjson

operator-sdk build $1
docker push $1

sed -i "s|image: .*|image: $1|g" deploy/operator.yaml
sed -i "s|imagePullPolicy: .*|imagePullPolicy: Always|g" deploy/operator.yaml
#sed -i "" 's|REPLACE_IMAGE|quay.io/example/memcached-operator:v0.0.1|g' deploy/operator.yaml
#sed -i "" 's|{{ REPLACE_IMAGE }}|$1|g' deploy/operator.yaml
#sed -i "" 's|{{ pull_policy\|default('\''Always'\'') }}|Always|g' deploy/operator.yaml

kubectl create -f deploy/crds/test.example.com_tests_crd.yaml
kubectl create -f deploy/service_account.yaml
kubectl create -f deploy/role.yaml
kubectl create -f deploy/role_binding.yaml
kubectl create -f deploy/operator.yaml

kubectl create -f deploy/crds/test.example.com_v1_test_cr.yaml
