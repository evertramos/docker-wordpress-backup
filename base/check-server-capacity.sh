# This function is part of a bigger script
#
# Be carefull when editing it

# Check disk space
check_disk_space() {
    echo "Check if there is enogh space in disk..."

    AVAILABLE_DISK_SPACE=$(df "$BACKUP_PATH_NAME" | awk 'NR==2 { print $4 }')

    if [ $AVAILABLE_DISK_SPACE -lt $DISK_SPACE_REQUIRED ]; then
        MESSAGE="You don´t have enough spce in disk to start a new customer environment."
        return 1
    fi
}

# Check ram memory available
check_ram_memory() {
    echo "Check if there is enogh ram memory..."

    AVAILABLE_MEMORY=$(awk '/^MemAvailable:/{print $2}' /proc/meminfo)

    if [ $AVAILABLE_MEMORY -lt $FREE_MEMORY_REQUIRED ]; then
        MESSAGE="You don´t have enough (RAM) memory to start a new customer environment."
        return 1
    fi
}

