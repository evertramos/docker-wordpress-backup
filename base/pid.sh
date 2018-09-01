# This function is part of a bigger script
#
# Be carefull when editing it

# Working with PID
save_pid() {
    echo $$ > $SCRIPT_PATH/$PID_FILE
}

delete_pid() {
    rm -f $SCRIPT_PATH/$PID_FILE
}

