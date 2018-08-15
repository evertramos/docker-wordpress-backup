# ----------------------------------------------------------------------
#
# This script is part of a another script! 
#
# >> Be very careful when editing it <<
#
# Developed by Evert Ramos
#
# This function will backup the wordpress files (wp-content)
#
# ----------------------------------------------------------------------

backup_wp_content() {

    echo "Creating a backup for the wp-content folder."
    
    # Current Date (ddmmyyy-hh)
    CURRENT_DATE=$(date '+%d%m%Y')

    # Set the backup file name here
    BACKUP_FILE=$CONTAINER_WP_NAME"-"$CURRENT_DATE".tar"

    # Check if backup file already exists
    if [ ! -e $SCRIPT_PATH"/../backup/"$BACKUP_FILE ]; then
        tar -cf $SCRIPT_PATH"/../backup/"$BACKUP_FILE $SCRIPT_PATH"/"$WP_CONTENT
    else
        # rename olde file 
        mv $SCRIPT_PATH"/../backup/"$BACKUP_FILE $SCRIPT_PATH"/../backup/"$BACKUP_FILE".old"

        # create a new backup
        tar -cf $SCRIPT_PATH"/../backup/"$BACKUP_FILE $SCRIPT_PATH"/"$WP_CONTENT
    fi
}

