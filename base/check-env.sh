# ----------------------------------------------------------------------
#
# This script is part of a another script! 
#
# >> Be very careful when editing it <<
#
# Developed by Evert Ramos
#
# This function will load '.env' file
#
# ----------------------------------------------------------------------

check_env_file() {

    echo "Check if '.env' file is set."

    if [ -e .env ]; then
        source .env
    else
        MESSAGE="'.env' file not found!"
        return 1
    fi
}

