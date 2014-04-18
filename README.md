dokku-acl-wrapper
=================

Wrapper for Dokku that adds additional simple access control.

## Installing

    $ wget -qO- https://raw.github.com/richardriman/dokku-acl-wrapper/master/bootstrap.sh | sudo bash

Bootstrap script is usable only if you have Dokku installed in standard location. If don't, you must do it manuly.

## Manual Instalation

  # cd /usr/local/bin
  # wget https://raw.github.com/richardriman/dokku-acl-wrapper/master/dokku-acl-wrapper
  # chmod +x dokku-acl-wrapper
  # touch /home/dokku/.acl
  # echo "/usr/local/bin/dokku-acl-wrapper" > /home/dokku/.sshcommand

## Configuration

Now you need define users and their applications to the file /home/dokku/.acl .

Format is very simple:

    user1:app1 app2
    user2:app3
    user3:app4 app5 app6

That's it!
