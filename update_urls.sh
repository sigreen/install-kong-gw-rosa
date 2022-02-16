#!/bin/bash

echo -e "\n*** Updating values.yaml"
yq -i eval ".env.proxy_url = \"http://proxy-kong$1\"" values.yaml
yq -i eval ".env.admin_gui_url = \"http://manager-kong$1\"" values.yaml
yq -i eval ".env.admin_api_uri = \"http://admin-kong$1\"" values.yaml
yq -i eval ".env.portal_gui_host = \"dev-portal$1\"" values.yaml
yq -i eval ".env.portal_api_url = \"http://dev-portal-api$1\"" values.yaml

echo -e "\n*** Updating session_conf files"
echo "$( jq --arg a "$1" '.cookie_domain = $a' admin_gui_session_conf )" > admin_gui_session_conf
echo "$( jq --arg a "$1" '.cookie_domain = $a' portal_session_conf )" > portal_session_conf
