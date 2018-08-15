# ---------------------------------------------------------------------e
#
# This script is part of a another script! Be careful when editing it..
#
# Developed by Evert Ramos
#
# This script will load everything from the base folder
#
# ----------------------------------------------------------------------

# Set Local Folder Name
LOCAL_FOLDER=base

# Get Current directory
LOCAL_PATH="$(dirname "$(readlink -f "$0")" )"

# Bootstrap file name
#BOOTSTRAP_FILE_NAME=$(basename "$0")
BOOTSTRAP_FILE_NAME="bootstrap.sh"

echo "reading bootstrap"

# This must have "local folder" in order to run the script from outsise
# of the local folder
for file in $LOCAL_PATH/$LOCAL_FOLDER/*
do
    if [ $file != $LOCAL_PATH/$LOCAL_FOLDER/$BOOTSTRAP_FILE_NAME ]; then
        source $file
    fi
done
