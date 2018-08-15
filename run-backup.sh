#!/usr/bin/env bash

# ----------------------------------------------------------------------
#
# Backup Script for Wordpress Database
#
# Developed by Evert Ramos
#
# This script is meant to be used with the repo:
#
# > https://github.com/evertramos/docker-wordpress-letsencrypt
#
# ----------------------------------------------------------------------

# ----------------------------------------------------------------------
# We will comment these next lines in order to treat all errors in the
# script exiting in case of failure
# ----------------------------------------------------------------------
# Basic bash settings - Careful with that!
#if test "$BASH" = "" || "$BASH" -uc 'a=();true "${a[@]}"' 2>/dev/null; then
#    # Bash 4.4, Zsh
#    set -euo pipefail
#else
#    # Bash 4.3 and older chokes on empty arrays with set -u.
#    set -eo pipefail
#fi
shopt -s nullglob globstar

# Get the sript file real path
SCRIPT_PATH="$(dirname "$(readlink -f "$0")")"

# Read all functions and files in base folder
source $SCRIPT_PATH"/base/bootstrap.sh"

# ----------------------------------------------------------------------
# PLEASE SET ON THE FOLLOWING LINE THE BACKUP FOLDER
# ----------------------------------------------------------------------
# BACKUP_PATH=./../backup
BACKUP_PATH=/backup

# ---------------------------------------------------------------------
#
# Function to call other functions and output messages from the script
#
# ---------------------------------------------------------------------
run_function() {

    echo "${yellow}[start]--------------------------------------------------${reset}"

    # Call the specified function
    if [ -n "$(type -t "$1")" ] && [ "$(type -t "$1")" = function ]; then
        echo "${cyan}...running function \"${1}\" to:${reset}"
        if [ ! -z $2 ]; then
            $1 $2
        else
            $1
        fi
    else
        echo "${red}>>> -----------------------------------------------------${reset}"
        echo "${red}>>>${reset}"
        echo "${red}>>>[ERROR] Function \"$1\" not found!${reset}"
        echo "${red}>>>${reset}"
        echo "${red}>>> -----------------------------------------------------${reset}"
        echo "${yellow}[ended with ${red}[ERROR]${yellow}]-------------------------------------${reset}"
        exit 1
    fi

    # Show result from the function execution
    if [ $? -ne 0 ]; then
        echo "${red}>>> -----------------------------------------------------${reset}"
        echo "${red}>>>${reset}"
        echo "${red}>>> Ups! Something went wrong...${reset}"
        echo "${red}>>>${reset}"
        echo "${red}>>> ${MESSAGE}${reset}"
        echo "${red}>>>${reset}"
        echo "${red}>>> -----------------------------------------------------${reset}"
        echo "${yellow}[ended with ${red}ERROR${yellow}/WARNING ($?)----------------------------${reset}"
        exit 1
    else
        echo "${green}>>> Success!${reset}"
    fi

    echo "${yellow}[end]----------------------------------------------------${reset}"
    echo
}

# ---------------------------------------------------------------------
#
# Function for this script
#
# ---------------------------------------------------------------------

# Symlink '.env' file to local folder
run_function symlink_env_file

# Read '.env' file from compose folder
run_function check_env_file

# Backup Database
run_function backup_database $BACKUP_PATH

# Compress file (database)
run_function compress_file $SCRIPT_PATH"/../backup/"$BACKUP_FILE

# Backup wp-content
run_function backup_wp_content

# Compress file (database)
run_function compress_file $SCRIPT_PATH"/../backup/"$BACKUP_FILE


exit 0
