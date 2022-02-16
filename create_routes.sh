#!/bin/bash

echo -e "\n*** Creating Kong Routes"
oc expose svc/my-kong-kong-proxy --hostname=proxy-kong$1 -n kong
oc expose svc/my-kong-kong-manager --hostname=manager-kong$1 -n kong
oc expose svc/my-kong-kong-admin --hostname=admin-kong$1 -n kong
oc expose svc/my-kong-kong-portal --hostname=dev-portal$1 -n kong
