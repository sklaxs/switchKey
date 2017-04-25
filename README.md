# switchKey
shell script for alternate i3 configuration between bépo and azerty

# dependence
you need to install xcape
see https://github.com/alols/xcape

my script can run without xcape (I use it for use space as mod), you need to comment xmodmap and xcape ligne in switchKey.sh and change modifier in the two i3 configuration files

# install
    cd ${HOME}
    mkdir shell && cd shell
    git clone https://github.com/sklaxs/switchKey.githttps://github.com/sklaxs/switchKey.git
    ln -s ${HOME}/shell/switchKey/i3/config_AZERTY ${HOME}/.i3/config_AZERTY
    ln -s ${HOME}/shell/switchKey/i3/config_BEPO ${HOME}/.i3/config_BEPO
    echo "${HOME}/shell/switchKey/switchKey.sh" >> ${HOME}/.profile
