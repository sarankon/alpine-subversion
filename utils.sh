#!/bin/sh

menu() {

    echo "1. create repo"
    echo "2. create user"
    echo "3. reboot apache2"
    echo "0. exit"

    read -r -p "select menu (1-3): " menu_selected

    if [ "$menu_selected" = 1 ] ; then
        create_repo
    elif [ "$menu_selected" = 2 ] ; then
        create_user
    elif [ "$menu_selected" = 3 ] ; then
        reboot_apache2
    else
        echo "selected menu invalid"
    fi
}

create_repo() {
    echo "create repo"
    read -r -p "repo name: " repo_name

    echo "creating repo ..."
    svnadmin create /var/svn/"$repo_name"
    chgrp -R apache /var/svn/"$repo_name"
    chmod -R 775 /var/svn/"$repo_name"
}

create_user() {
    echo "create user"
    # echo "username: "
    read -r -p "username: " username

    # echo "password: "
    read -r -p "password: " password

    # echo "confirm password: "
    read -r -p "confirm password" conf_password

    if [ "$password" = "$conf_password" ] ; then
        echo "creating user ..."
        htpasswd -bc /etc/apache2/conf.d/davsvn.htpasswd "$username" "$password"
    else
        echo "password don't match"
    fi
}

reboot_apache2() {
    echo "rebooting apache2"
    service apache2 restart
}

menu
