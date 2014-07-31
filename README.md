dokku-acl-wrapper
=================

[![Build Status](https://travis-ci.org/richardriman/dokku-acl-wrapper.svg?branch=master)](https://travis-ci.org/richardriman/dokku-acl-wrapper)

Wrapper for Dokku that adds additional simple access control.

## Installing

    $ wget -qO- https://raw.github.com/richardriman/dokku-acl-wrapper/master/bootstrap.sh | sudo bash

Bootstrap script is usable only if you have Dokku installed in standard location. If don't, you must do it manually.

## Manual Installation

    # cd /usr/local/bin
    # wget https://raw.github.com/richardriman/dokku-acl-wrapper/master/dokku-acl-wrapper
    # chmod +x dokku-acl-wrapper
    # touch /home/dokku/ACL
    # mv /home/dokku/.sshcommand /home/dokku/.sshcommand.prev
    # echo "/usr/local/bin/dokku-acl-wrapper" > /home/dokku/.sshcommand

## Configuration

Now you need define users and their applications in the file /home/dokku/ACL.

Format of the ACL file is pretty simple:

    user1:app1 app2
    user2:app3
    user3:app4 app5 app6

That's it!
