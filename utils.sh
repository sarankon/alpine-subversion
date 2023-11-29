#!/bin/sh

menu() {

    echo "1. create repo"
    echo "2. create user"
    echo "0. exit"

    read -r -p "select menu (1-2): " menu_selected

    if [ "$menu_selected" = 1 ] ; then
        create_repo
    elif [ "$menu_selected" = 2 ] ; then
        create_user
    else
        echo "selected menu invalid"
    fi
}

create_repo() {
    echo "create repo name: "
    read -r repo_name

    echo "creating repo ..."
    svnadmin create /var/svn/"$repo_name"
    chgrp -R apache /var/svn/"$repo_name"
    chmod -R 775 /var/svn/"$repo_name"
}

create_user() {
    echo "create user"
    echo "username: "
    read -r username

    echo "password: "
    read -r password

    echo "confirm password: "
    read -r conf_password

    if [ "$password" = "$conf_password" ] ; then
        echo "creating user ..."
        htpasswd -bc /etc/apache2/conf.d/davsvn.htpasswd "$username" "$password"
    else
        echo "password don't match"
    fi
}

menu