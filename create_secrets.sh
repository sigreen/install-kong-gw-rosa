#!/bin/bash

echo -e "\n*** Creating namespace"
oc create namespace kong

echo -e "\n*** Creating RBAC superuser"
oc create secret generic kong-enterprise-superuser-password -n kong --from-literal=password=kong

echo -e "\n*** Creating secret for sessions"
oc create secret generic kong-session-config -n kong --from-file=admin_gui_session_conf --from-file=portal_session_conf

echo -e "\n*** Creating secret for license"
oc create secret generic kong-enterprise-license -n kong --from-file=./license