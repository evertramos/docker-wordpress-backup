#!/usr/bin/env bash

CRONTAB_FILE=current_crontab
CRONTAB_SCRIPT="$(dirname "$(readlink -f "$0")")""/run-backup.sh"
CRONTAB_SIGNATURE="CRONTAB_RULE_DOCKER_WORDPRESS_BACKUP"


#CRONTAB_RULE="00 03 * * 1-5 $CRONTAB_SCRIPT"
CRONTAB_RULE="00 21 * * 1-5 "$CRONTAB_SCRIPT" # "$CRONTAB_SIGNATURE

# Write your current crontab to a file
crontab -l > $CRONTAB_FILE

# Remove old lines of the same job
sed -i "/$CRONTAB_SIGNATURE/d" "$CRONTAB_FILE"

# Add your new job rule in the currect crontab file
echo "$CRONTAB_RULE" >> $CRONTAB_FILE

# Update new crontab
crontab $CRONTAB_FILE

rm $CRONTAB_FILE

exit 0

