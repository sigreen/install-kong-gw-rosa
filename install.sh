#!/bin/bash
echo -e "This script will install Kong on a provisioned Red Hat Openshift AWS (ROSA) cluster"
echo -e "Keep in mind that this service is cost intensive so delete it as soon as you do not need it anymore more with the also included delete.sh script"
echo -e "*** Prerequesites"
echo -e "*** 1. An AWS account (obviously)"
echo -e "*** 2. An Red Hat account"
echo -e "*** 3. aws cli installed on your machine"
echo -e "*** 4. aws cli configured with a user having enough permissions"
echo -e "*** 5. rosa installed"
echo -e "*** 6. oc cli"
echo -e "*** 7. Helm (version 3, not version 2!)"
echo -e "*** 8. yq"
echo -e "*** 9. jq"
echo -e "******************************************"
echo
echo Your openshift domain is: $1
echo
echo -e "If you are ready go press ENTER, otherwise stop now using ctrl-c"

read

. ./update_urls.sh

echo -e "\n*** Creating required Secrets"
. ./create_secrets.sh

echo -e "\n*** Creating standalone ephemeral instance of Postgresql"
. ./create_postgres.sh

echo -e "\n*** Installing Kong Enterprise"
helm install my-kong kong/kong -n kong --values ./values.yaml

echo -e "\n ☕ Creating Kong routes"
. ./create_routes.sh

echo -e "\n*** Here is the proxy route hostname for you: "
oc get routes -n kong -o json | jq -r '[.items[] | {spec:.status.ingress,name:.metadata.name}]' | jq -r '.[] | select(.name|test("my-kong-kong-proxy")) | .spec[0].host'

echo -e "\n*** Here is the Kong manager URL: "
oc get routes -n kong -o json | jq -r '[.items[] | {spec:.status.ingress,name:.metadata.name}]' | jq -r '.[] | select(.name|test("my-kong-kong-manager")) | .spec[0].host'

echo -e "\n*** Here is the Dev Portal URL: "
oc get routes -n kong -o json | jq -r '[.items[] | {spec:.status.ingress,name:.metadata.name}]' | jq -r '.[] | select(.name|test("my-kong-kong-portal")) | .spec[0].host'