# switchKey
shell script for alternate i3 configuration between bépo and azerty

# dependence
you need to install xcape
see https://github.com/alols/xcape

my sript can run without xcape (I use it for use space as mod), you need to comment xmodmap and xcape ligne in switchKey.sh

# install
    cd ${HOME}
    mkdir shell && cd shell
    git clone https://github.com/sklaxs/switchKey.githttps://github.com/sklaxs/switchKey.git
    ln -s ${HOME}/shell/switchKey/i3/config_AZERTY ${HOME}/.i3/config_AZERTY
    ln -s ${HOME}/shell/switchKey/i3/config_BEPO ${HOME}/.i3/config_BEPO

if you want to automatically switch in bepo at startup
    echo "${HOME}/shell/switchKey/switchKey.sh" >> ${HOME}/.profile
