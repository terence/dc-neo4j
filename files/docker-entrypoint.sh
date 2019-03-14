#!/usr/bin/env bash

# Memory
export NEO4J_dbms_memory_heap_initial__size=$(((${PMEM:-2048}/8)*5))m
export NEO4J_dbms_memory_heap_max__size=${NEO4J_dbms_memory_heap_initial__size}
export NEO4J_dbms_memory_pagecache_size=$(((${PMEM:-2048}/8)*2))m
export NEO4J_dbms_logs_debug_level=${LOG_LEVEL:-INFO}

# Elasticsearch
if [[ "${SEARCH_INDEX_FROM_SCRATCH:-n}" == "y" ]]; then
  echo "ES: Re-create from scratch"
  sed -i "s|##__ES_BACK_INIT__##|$(($(date +%s)*1000 + 5*60*1000))|g" /custom.conf
else
  sed -i "s|##__ES_BACK_INIT__##|0|g" /custom.conf
fi
sed -i "s|##__ES_PSWD__##|${ES_PSWD}|g" /custom.conf

# Permissions and configuration
mkdir -p /data/backups /data/import
chown -Rf neo4j:neo4j /data /logs
chmod -f 0755 /data /logs

cd /var/lib/neo4j && rmdir import || rm -f import || true && ln -fs /data/import import

cd conf
if [[ ! -e "neo4j.conf.upstream" ]]; then
  cp -fp neo4j.conf neo4j.conf.upstream
fi
cat neo4j.conf.upstream /custom.conf > neo4j.conf
cd -

exec /docker-entrypoint-upstream.sh $@

