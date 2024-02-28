#!/bin/bash
echo "DB_DATABASE=${db_database}" >> /etc/environment
echo "DB_USER=${db_user}" >> /etc/environment
echo "DB_PASSWORD=${db_password}" >> /etc/environment
echo "DB_HOST=${db_host}" >> /etc/environment