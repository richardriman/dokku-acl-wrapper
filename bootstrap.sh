#!/usr/bin/env bash

set -eo pipefail

export DOKKU_ACL_REPO=${DOKKU_ACL_REPO:-"https://github.com/richardriman/dokku-acl-wrapper.git"}

if [ ! -f /home/dokku/.sshcommand ]; then
    echo "Dokku isn't installed or installed in an unknown location. For manual installation instructions, consult https://github.com/richardriman/dokku-acl-wrapper ."
    exit 1
fi

cd ~ && test -d dokku-acl-wrapper || git clone $DOKKU_ACL_REPO
cd dokku-acl-wrapper
git fetch origin

if [[ -n $DOKKU_ACL_BRANCH ]]; then
    git checkout origin/$DOKKU_ACL_BRANCH
elif [[ -n $DOKKU_ACL_TAG ]]; then
    git checkout $DOKKU_ACL_TAG
fi

TARGET="/usr/local/bin/dokku-acl-wrapper"

cp dokku-acl-wrapper ${TARGET}
cp ACL.sample /home/dokku/ACL.sample
chmod +x ${TARGET}
touch /home/dokku/ACL
cp /home/dokku/.sshcommand /home/dokku/.sshcommand.prev
echo ${TARGET} > /home/dokku/.sshcommand

echo "Almost done!"
echo "Now you need define users and their applications to the file /home/dokku/ACL ."
echo "Format of this file is pretty simple:"
echo
echo "user1:app1 app2"
echo "user2:app3"
echo "user3:app4 app5 app6"
echo
echo "That's it!"

exit 0
