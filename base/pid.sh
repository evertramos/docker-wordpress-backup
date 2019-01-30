# This function is part of a bigger script
#
# Be carefull when editing it

# Working with PID
save_pid() {

    if [ ! -z ${PID_FILE+X} ]; then
        echo $$ > $SCRIPT_PATH/$PID_FILE
    else
        MESSAGE="You must set the PID_FILE in your .env file"
        return 1
    fi

}

delete_pid() {
    rm -f $SCRIPT_PATH/$PID_FILE
}

