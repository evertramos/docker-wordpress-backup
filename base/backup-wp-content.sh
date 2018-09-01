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
    if LONG_TERM_BACKUP; then
        CURRENT_DATE=$(date '+%Y%m')
        BACKUP_PATH=$BACKUP_PATH"/"$BACKUP_LONG_TERM_PATH_NAME
    else
        CURRENT_DATE=$(date '+%Y%m%d')
    fi

    # Set the backup file name here
    BACKUP_FILE=$CURRENT_DATE"-"$CONTAINER_WP_NAME".tar"

    # Set the backup full path
    if [ ! -z $1 ]; then
        # Create folder if it does not exists
        mkdir -p $BACKUP_PATH"/"$1

        # Fullfill the Backup_Full_Path variable
        BACKUP_FULL_PATH=$BACKUP_PATH"/"$1
    else
        # Create folder if it does not exists
        mkdir -p $BACKUP_PATH

        # Fullfill the Backup_Full_Path variable
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

