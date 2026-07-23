#!/usr/bin/env bash
set -euo pipefail
rm -rf staging restored db_backup.tar.gz db_backup.sha256 answer.txt
mkdir -p staging
echo "customer records v3" > staging/customers.db
echo "transaction log v3" > staging/transactions.log
tar -czf db_backup.tar.gz -C staging .
( cd staging && sha256sum customers.db transactions.log ) > db_backup.sha256
rm -rf staging
echo "db_backup.tar.gz and db_backup.sha256 are ready. Restore and verify."
