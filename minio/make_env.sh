#!/bin/bash
echo "MINIO_ROOT_USER=$(pass infra/minio/root_user)" > .env
echo "MINIO_ROOT_PASSWORD=$(pass infra/minio/root_pass)" >> .env
chmod 600 .env