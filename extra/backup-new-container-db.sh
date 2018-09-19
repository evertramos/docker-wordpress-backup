echo "Creating a manual backup for the Database."

# Current Date (ddmmyyy-hh)
if $LONG_TERM_BACKUP; then
    CURRENT_DATE=$(date '+%Y%m')
else
    CURRENT_DATE=$(date '+%Y%m%d')
fi

# Set the backup file name here
BACKUP_FILE=$CURRENT_DATE"-"$1".sql"

# Set the backup full path
if [ ! -z ${DB_BACKUP_PATH_NAME+X} ]; then
    # Create folder if it does not exists
    mkdir -p $BACKUP_PATH"/"$DB_BACKUP_PATH_NAME

    # Fullfill the Backup_Full_Path variable
    BACKUP_FULL_PATH=$BACKUP_PATH"/"$DB_BACKUP_PATH_NAME
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
docker exec -i $1 /usr/bin/mysqldump -u $3 --password=$4 $2 > $BACKUP_FULL_PATH"/"$BACKUP_FILE

BACKUP_FILE=$BACKUP_FULL_PATH"/"$BACKUP_FILE

# Compress file (database)
run_function compress_file $BACKUP_FILE

return 0
