# ----------------------------------------------------------------------
#
# This script is part of a another script! 
#
# >> Be very careful when editing it <<
#
# Developed by Evert Ramos
#
# This function will compress a file
#
# ----------------------------------------------------------------------

compress_file() {

    echo "Compressing file."

    if [ ! -z $1 ]; then
        ZIP_TYPE=gzip

        if [ ! -x "$(command -v "$ZIP_TYPE")" ]; then
            echo "'$ZIP_TYPE' is not installed!"
            #MESSAGE="'$ZIP_TYPE' is not installed!"
            #return 1
        fi

        gzip -f $1
    fi
}

