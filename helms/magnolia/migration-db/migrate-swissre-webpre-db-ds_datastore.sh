#!/usr/bin/env bash

set -euo pipefail

BGREEN='\033[1;32m'
RED='\033[0;31m'
CYAN='\033[0;36m'
COLOR_OFF='\033[0m' # No Color


function usage {
    echo "Usage:"
    echo "    $0 -k <search_key> "
    echo "Options:"
    echo "    -h <DBHOST> : required, server host address, e.g. '192.168.1.49' , 'dev-magnolia-helm-author-db.dev.svc.cluster.local'"
    echo "    -p <DBPORT> : required, searching key, e.g. '5432'"
    echo "    -f <DBDUMPFILEPATH> : required, searching key, e.g. '/tmp/author/magnolia-author.dump'"
    echo "    -f <DBSCHEMA> : required, schema name, e.g. 'author' , 'public'"
    echo "    -u <DBUSER> : required, schema name, e.g. 'postgres'"
}

function error {
    echo -e "${RED}$*${COLOR_OFF}"
}

DBHOST=localhost
DBPORT=5432
DBDUMPFILEPATH=$HOME"/author/magnolia-author.dump"
DBSCHEMA=author
DBUSER=postgres

while getopts ":h:p:f:d:u:" opt; do
    case $opt in
        h)
            DBHOST=$OPTARG
            ;;
        p)
            DBPORT=$OPTARG
            ;;
        f)
            DBDUMPFILEPATH=$OPTARG
            ;;
        d)
            DBSCHEMA=$OPTARG
            ;;
        u)
            DBUSER=$OPTARG
            ;;
        \?)
            error "Error: Invalid option: -$OPTARG" >&2
            usage
            exit 1
            ;;
    esac
done

if [ -z "${DBHOST}" ]; then
    error "Error: Please enter the server host, such as: 192.168.1.49 or service name (dev-magnolia-helm-author-db.dev.svc.cluster.local)"
    usage
    exit 1
fi

if [ -z "${DBPORT}" ]; then
    error "Error: Please enter the server port, such as: 5432"
    usage
    exit 1
fi

if [ -z "${DBDUMPFILEPATH}" ]; then
    error "Error: Please enter the dump file location, such as: /tmp/magnolia-author.dump"
    usage
    exit 1
fi

if [ -z "${DBSCHEMA}" ]; then
    error "Error: Please enter the schema name, such as: author or public"
    usage
    exit 1
fi

if [ -z "${DBUSER}" ]; then
    error "Error: Please enter the user, such as: postgres"
    usage
    exit 1
fi

echo ""
echo -e "${BGREEN}================================================================================="
echo "    Host : ${DBHOST}                                                                     "
echo "    Port : ${DBPORT}                                                                      "
echo "    Dump file : ${DBDUMPFILEPATH}                                                                      "
echo "    Schema : ${DBSCHEMA}                                                                      "
echo "    User : ${DBUSER}                                                                      "
echo -e "=================================================================================${COLOR_OFF}"
echo ""

#declare array of workspaces to migrate
declare -a INCLUDEWORKSPACES


echo ">>START Executing pg_restore ds_datastore <<"
  pgDsDatastoreRestore="time pg_restore -h "$DBHOST" -p "$DBPORT" -U "$DBUSER" --data-only -d "$DBSCHEMA" -t ds_datastore --jobs=10 --verbose $DBDUMPFILEPATH > ds_datastore-author-$(date +%Y%m%d).log 2>&1"
  echo "$pgDsDatastoreRestore - $(date +%Y_%m_%d:%k:%M:%S)"
  eval "$pgDsDatastoreRestore"
echo ">>FINISH Executing pg_restore ds_datastore <<"