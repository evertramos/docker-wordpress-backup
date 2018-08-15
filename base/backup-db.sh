# ----------------------------------------------------------------------
#
# This script is part of a another script! 
#
# >> Be very careful when editing it <<
#
# Developed by Evert Ramos
#
# This function will backup the database from container
#
# ----------------------------------------------------------------------

backup_database() {

    echo "Creating a backup for the Database."
    
    # Current Date (ddmmyyy-hh)
    CURRENT_DATE=$(date '+%d%m%Y-%H')

    # Set the backup file name here
    BACKUP_FILE=$CONTAINER_DB_NAME"-"$CURRENT_DATE".sql"

    # Check if backup file already exists
    if [ ! -e $SCRIPT_PATH"/../backup/"$BACKUP_FILE ]; then
        echo "não existe"
        docker exec -i $CONTAINER_DB_NAME /usr/bin/mysqldump -u $MYSQL_USER --password=$MYSQL_PASSWORD $MYSQL_DATABASE > $SCRIPT_PATH"/../backup/"$BACKUP_FILE
    else
        # rename olde file 
        mv $SCRIPT_PATH"/../backup/"$BACKUP_FILE $SCRIPT_PATH"/../backup/"$BACKUP_FILE".old"

        # create a new backup
        docker exec -i $CONTAINER_DB_NAME /usr/bin/mysqldump -u $MYSQL_USER --password=$MYSQL_PASSWORD $MYSQL_DATABASE > $SCRIPT_PATH"/../backup/"$BACKUP_FILE
    fi
}

