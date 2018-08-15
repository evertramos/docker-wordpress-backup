# ----------------------------------------------------------------------
#
# This script is part of a another script! 
#
# >> Be very careful when editing it <<
#
# Developed by Evert Ramos
#
# This function will symlink the .env file from compose folder
#
# ----------------------------------------------------------------------

symlink_env_file() {

    echo "Creating a symlink for the '.env' file in local folder."

    if [ ! -e .env ]; then
        ln -s ./../compose/.env .
    fi
}

