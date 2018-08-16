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

    # Set the backup full path
    if [ ! -z $1 ]; then
        BACKUP_FULL_PATH=$BACKUP_PATH"/"$1
    else
        BACKUP_FULL_PATH=$BACKUP_PATH
    fi

    # Check if directory exists
    if [ ! -d $BACKUP_FULL_PATH ]; then
        MESSAGE="The backup folder ($BACKUP_FULL_PATH) does not exists, please create it before continue"
        return 1
    fi

    # Check if backup file already exists
    if [ -e $BACKUP_FULL_PATH"/"$BACKUP_FILE ]; then
        # rename olde file 
        mv $BACKUP_FULL_PATH"/"$BACKUP_FILE $BACKUP_FULL_PATH"/"$BACKUP_FILE".old"
    fi

    # create a new backup
    tar -cf $BACKUP_FULL_PATH"/"$BACKUP_FILE $SCRIPT_PATH"/"$WP_CONTENT

    BACKUP_FILE=$BACKUP_FULL_PATH"/"$BACKUP_FILE
}

