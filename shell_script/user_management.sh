#!/bin/bash
####################
#Author:GitanjaliGarg
#Topic:User account management
####################
#

create_user()
{

echo "Enter username:"
read username

echo "Enter password"
read -s password

     if id "$username" &> /dev/null;
      then
        echo "user already exists"
        exit 0

      else

        sudo useradd -m $username

        echo -e "$password\n$password" | sudo passwd $username

        if [ $? -eq 0 ];
        then
                echo "user created successfully"
        else
                echo "Failed to set password"
                exit 1
        fi
     fi



}



delete_user()
{

                echo "Enter username:"
                read username

        if ! id "$username" &> /dev/null;
        then
          echo "user does not exists"
          exit 1
        fi


              sudo userdel -r "$username"
               if [ $? -eq 0 ];
               then
               echo "user has been successfully deleted"

               else
               echo "user has not been deleted"
               exit 1
               fi




}

reset_user()
{

        echo "Enter username:"
        read username

        if ! id "$username" &> /dev/null;
        then
                echo "user does not exist"
                exit 1
        fi

        echo "Enter new password:"
        read -s new_pass

        echo -e "new_pass\nnew_pass" | sudo passwd $username

        if [ $? -eq 0 ];
        then
                echo "password has been reset"
        else
                echo "password did not reset"
                exit 1
        fi
}

list_user()
{
        echo "listing all the users"

      awk -F: '{ print $1, $3 }' /etc/passwd

}

help_user()
{
      echo "Options:"
    echo "  -c, --create        Create a new user account"
    echo "  -d, --delete        Delete an existing user account"
    echo "  -r, --reset         Reset a user's password"
    echo "  -l, --list          List all user accounts on the system"
    echo "  -h, --help          Show this help message"

}

case "$1" in
        -c|--create )
        create_user
        ;;
       -d|--delete )
        delete_user
        ;;
       -r|--reset )
         reset_user
        ;;
       -l|--list )
        list_user
        ;;
       -h|--help )
        help_user
        ;;
*)

        echo "invalid option"
        ;;
esac

