#!/bin/bash
# Purpose: Get the aws RDS Endpoint and split the rds port from the entire rds endpoint
# Author: Praful Patel
# Date & Time: OCT 21, 2023
# Objective: The objective of this sript is to remove the rds port from the entire rds endpoint string so that it can use and login to rds through terraform 
# To extracts the host or hostname from the RDS endpoint. It uses the sed command to remove the port part (if any) from the RDS endpoint. The result is stored in the rds_host variable, which will be used as the host for connecting to the RDS instance.
# ------------------------------------------

rds_endpoint="$1"
rds_host="$(echo $rds_endpoint | sed 's/:.*//')"
echo "Connecting to RDS without specifying the port..."
mysql -h $rds_host -u admin -ppassword -e 'SELECT 1;'
echo "Importing SQL dump file..."
mysql -h $rds_host -u admin -ppassword < /tmp/obbs.sql
