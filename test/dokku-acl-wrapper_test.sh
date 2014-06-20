#!/bin/bash

. test/assert.sh

STUBS="test/stubs"
PATH="$STUBS:.:$PATH"
DOKKU_ROOT="test/fixtures/dokku"
dokku_acl_wrapper="PATH=$PATH HOME=$DOKKU_ROOT DOKKU_ROOT=$DOKKU_ROOT dokku-acl-wrapper"

HELP="    config <app>                                    display the config vars for an application\n    config:get <app> KEY                            display a config value for an application\n    config:set <app> KEY=VALUE [KEY2=VALUE2 ...]    set one or more config vars for an application\n    config:unset <app> KEY [KEY2 ...]               unset one or more config vars for an application\n    help                                            print the list of commands\n    logs <app> [-t]                                 show the last logs for an application (-t follows)\n    run <app> <cmd>                                 run a command in the environment of an application"

# should print a help message when no command set
assert "$dokku_acl_wrapper" "Usage:\n$HELP"
assert_raises "$dokku_acl_wrapper" 1

# should print a help message when help command requested
assert "$dokku_acl_wrapper help" "$HELP"
assert_raises "$dokku_acl_wrapper help" 0

# user1 should have access to app1
assert "NAME=user1 $dokku_acl_wrapper config app1" "[stub: dokku config app1]"
assert_raises "NAME=user1 $dokku_acl_wrapper config app1" 0

# user1 shouldn't have access to app3
assert "NAME=user1 $dokku_acl_wrapper config app3" ""
assert "NAME=user1 $dokku_acl_wrapper config app3 2>&1" "You don't have application named 'app3'. Please verify application name and try again."
assert_raises "NAME=user1 $dokku_acl_wrapper config app3" 1

# user3 should have access to app1
assert "NAME=user3 $dokku_acl_wrapper config app1" "[stub: dokku config app1]"
assert_raises "NAME=user3 $dokku_acl_wrapper config app1" 0

# end of test suite
assert_end examples
