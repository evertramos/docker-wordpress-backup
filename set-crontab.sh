#!/usr/bin/env bash

source .env

if [ $? -ne 0 ]; then
    echo 
    echo ">>> ---------------------------------------------------------"
    echo ">>> "
    echo ">>> You must symlink your '.env' file with your settings from"
    echo ">>> your docker-wordpress-letsencrypt folder and set contrab"
    echo ">>> rule variable at '\$BACKUP_CRONTAB_RULE'"
    echo ">>> "
    echo ">>> ---------------------------------------------------------"
    echo 
    exit 1
fi

if [ -z ${BACKUP_CRONTAB_RULE+X} ]; then
    echo 
    echo ">>> ---------------------------------------------------------"
    echo ">>> "
    echo ">>> The variable '\$BACKUP_CRONTAB_RULE' was not set in your"
    echo ">>> '.env' file. Please update this option and try again."
    echo ">>> "
    echo ">>> ---------------------------------------------------------"
    echo 
    exit 1
fi

CRONTAB_FILE=current_crontab
CRONTAB_SCRIPT="$(dirname "$(readlink -f "$0")")""/run-backup.sh"
CRONTAB_SIGNATURE="CRONTAB_RULE_DOCKER_WORDPRESS_BACKUP"
CRONTAB_RULE=$BACKUP_CRONTAB_RULE" "$CRONTAB_SCRIPT" # "$CRONTAB_SIGNATURE

# Write your current crontab to a file
crontab -l > $CRONTAB_FILE

# Remove old lines of the same job
sed -i "/$CRONTAB_SIGNATURE/d" "$CRONTAB_FILE"

# Add your new job rule in the currect crontab file
echo "$CRONTAB_RULE" >> $CRONTAB_FILE

# Update new crontab
crontab $CRONTAB_FILE

rm $CRONTAB_FILE

echo
echo "Crontab updated with this settings:"
echo "$CRONTAB_RULE"
echo

exit 0

