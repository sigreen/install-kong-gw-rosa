#!/bin/bash

echo -e "\n*** Creating Postgres DB"
oc new-app -e POSTGRESQL_USER=kong -e POSTGRESQL_PASSWORD=kong -e POSTGRESQL_DATABASE=kong postgresql:latest -n kong