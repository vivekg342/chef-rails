#!/bin/bash

if [ -z $USER ]
then
  USER="root"
fi

tar cj . | ssh $USER@$HOST "sudo /bin/bash -c '((test -z `which bzip2` && apt-get -y install bzip2) || true) &&
rm -rf ~/chef &&
mkdir ~/chef &&
(mkdir ~/chef-cache > /dev/null 2>&1 || true) &&
cd ~/chef &&
tar jx &&
HOST=$HOST CONFIG=$CONFIG ./install.sh'"
