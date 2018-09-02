# ----------------------------------------------------------------------
#
# This script is part of a another script! 
#
# >> Be very careful when editing it <<
#
# Developed by Evert Ramos
#
# This function will set your cron rule in your user's crontab
#
# ----------------------------------------------------------------------

set_backup_crontab_rule () {

    echo "Set Crontab Rules."
    
    CRONTAB_FILE=current_crontab
    #CRONTAB_SCRIPT="$(dirname "$(readlink -f "$0")")""/run-backup.sh"
    CRONTAB_SCRIPT="$SCRIPT_PATH""/run-backup.sh"

    if [ ! -z "$BACKUP_CRONTAB_RULE" ]; then
        CRONTAB_SIGNATURE="CRONTAB_RULE_DOCKER_WORDPRESS_BACKUP"
        CRONTAB_RULE=$BACKUP_CRONTAB_RULE" "$CRONTAB_SCRIPT" # "$CRONTAB_SIGNATURE
        record_crontab_file
    fi

    if [ ! -z "$BACKUP_LONG_TERM_CRONTAB_RULE" ]; then
        CRONTAB_SIGNATURE="LONG_TERM_CRONTAB_RULE_DOCKER_WORDPRESS_BACKUP"
        CRONTAB_RULE=$BACKUP_LONG_TERM_CRONTAB_RULE" "$CRONTAB_SCRIPT" "LONG_TERM_TRUE" # "$CRONTAB_SIGNATURE
        record_crontab_file
    fi
}

record_crontab_file () {

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
}
