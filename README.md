# switchKey
shell script for alternate i3 configuration between bépo and azerty

# dependence
you need to install xcape
see https://github.com/alols/xcape

my script can run without xcape (I use it for use space as mod), you need to comment xmodmap and xcape line in switchKey.sh and change modifier in the two i3 configuration files

# install
    cd ${HOME}
    mkdir shell && cd shell
    git clone https://github.com/sklaxs/switchKey.githttps://github.com/sklaxs/switchKey.git
    ln -s ${HOME}/shell/switchKey/i3/config_AZERTY ${HOME}/.i3/config_AZERTY
    ln -s ${HOME}/shell/switchKey/i3/config_BEPO ${HOME}/.i3/config_BEPO
    echo "${HOME}/shell/switchKey/switchKey.sh" >> ${HOME}/.profile

## i3 default configuration
if you want to use i3 shotcuts like i3 default configuration, you can use the configurations files present in switchKey/i3/default (adapt the ln command for this)
