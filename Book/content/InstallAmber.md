Getting Amber to run
====================

Build node
----------

Download tarball from nodejs.org

    ./configure
    make
    sudo make install

Or use you package manager

    sudo apt-get install nodejs

Configure npm so that you do not need sudo
------------------------------------------

### Create npm folder under $HOME

    cd $HOME
    mkdir npm

### Let npm know where you want to put stuff

    npm config set prefix=~/npm

### Adjust the $PATH so that things can be found

In ~/.profile, add at the end:

    export PATH="$PATH:$HOME/npm/bin"

Install the usual suspects for node based work
----------------------------------------------

    npm -g install bower
    npm -g install grunt

Install amber-cli
-----------------

amber-cli is all you need to develop Amber applications.
If you want to modify Amber, you would clone the Amber Github repo.

    npm -g install amber-cli

This should give you version 0.13

