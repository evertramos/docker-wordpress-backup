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

# ---------------------------------------------------------------------
# 
# Setting '.env' file location for the docker-wordpress-letsnecrypt
#
# ---------------------------------------------------------------------
ENV_FILE_LOCATION=./../compose

# Symlink '.env' file to local folder
run_function symlink_env_file

# Read '.env' file from compose folder
run_function check_env_file

# Check if script is already running
save_pid
trap 'delete_pid' EXIT SIGQUIT SIGINT SIGSTOP SIGTERM ERR

# Check Server Capacity
#run_function check_ram_memory
#run_function check_disk_space

# Clean up old backup if needed
source $SCRIPT_PATH/clean-backup.sh

# ---------------------------------------------------------------------
#
# Backup Location Settings
#
# ---------------------------------------------------------------------
# Please note that the basic configuration sets the backup on the folder outside
# the compose folder for docker-wordpress-letsencrypt
#
# If you want to set your own location please update your .env file accordingly
# ----------------------------------------------------------------------
BACKUP_PATH=$BACKUP_PATH_NAME

# ----------------------------------------------------------------------
# Long Term Backup
# ----------------------------------------------------------------------
LONG_TERM_BACKUP=false
if [ ! -z "$BACKUP_LONG_TERM_PATH_NAME" ] && [ ! -z "$BACKUP_LONG_TERM_RETENTION" ] && [ ! -z $1 ]; then
    echo
    echo "Running a long term backup!"
    echo

    LONG_TERM_BACKUP=true
    BACKUP_PATH=$BACKUP_PATH"/"$BACKUP_LONG_TERM_PATH_NAME
#    run_function clean_backup_long_term
fi

# Backup Database
# Set the first parameter as the subfolder name
#if [ -z ${DB_BACKUP_PATH_NAME+X} ]; then
#    run_function backup_database
#else
#    run_function backup_database $DB_BACKUP_PATH_NAME
#fi

# Compress file (database)
#run_function compress_file $BACKUP_FILE

# Backup wp-content
# Set the first parameter as the subfolder name
#if [ -z ${WP_BACKUP_PATH_NAME+X} ]; then
#    run_function backup_wp_content
#else
#    run_function backup_wp_content $WP_BACKUP_PATH_NAME
#fi

# Compress file (database)
#run_function compress_file $BACKUP_FILE

# Run Extra Scripts if exists
if [ -e $SCRIPT_PATH"/extra-script.sh" ]; then
    source  $SCRIPT_PATH/extra-script.sh
fi


exit 0
