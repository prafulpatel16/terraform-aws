#!/bin/bash
RDS_ENDPOINT="${1}"
RDS_HOST=$(echo "$RDS_ENDPOINT" | sed 's/:.*//')
echo "RDS_HOST=${RDS_HOST}"
