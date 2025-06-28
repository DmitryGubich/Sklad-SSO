#!/bin/bash
set -e

psql -v ON_ERROR_STOP=1 --username postgres --dbname postgres <<-EOSQL
	CREATE SCHEMA sso_schema;
	CREATE SCHEMA inventory_schema;
EOSQL