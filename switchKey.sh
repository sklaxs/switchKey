# !/bin/bash
## DESCRIPTION
# This script alternate keyboard mapping between BÉPO and AZERTY, change i3
# shotcuts, and remap space and alt-gr keys for allow to use space as moddifier
# and alt-gr as underscore in bepo if those switches used alone

## CONST
TMPFILE="/tmp/switchKey.txt"
ACTUALKEY="$(setxkbmap -print | sed -n 5p | cut -c33-35)"

if [ ! -f ${TMPFILE} ]
then
  BEPOSWITCH=""
else
  BEPOSWITCH=$(sed -n "2 p" ${TMPFILE})
fi

## FUNCTIONS
SwitchBepo()
{
  setxkbmap fr bepo # we change keyboard mapping
  cp ${HOME}/.i3/config_BEPO ${HOME}/.i3/config # we alternate i3 config file
  i3 reload # we reload i3
  ResetXmodMap "bepo"
  SetAlternateKey "space" "Hyper_L" "65" ${BEPOSWITCH}
  SetAlternateKey "underscore" "ISO_Level3_Shift" "108" ${BEPOSWITCH}
  }

SwitchAzerty()
{
  setxkbmap fr oss # we change keyboard mapping
  cp ${HOME}/.i3/config_AZERTY ${HOME}/.i3/config # we alternate i3 config file
  i3 reload # we reload i3
  ResetXmodMap "azerty"
  SetAlternateKey "space" "Hyper_L" "65" "False"
}

ResetXmodMap()
{
  # we reset xmodmap for mod3, mod4 and control
  keyboard="$1"
  case ${keyboard} in
    bepo)
      xmodmap -e "clear mod3"
#      xmodmap -e "clear control"
      xmodmap -e "clear mod4"
      xmodmap -e "add mod3 = Hyper_L"
      xmodmap -e "add mod4 = Super_L Super_R"
#      xmodmap -e "add mod4 = Control_L Control_R"
#      xmodmap -e "add control = Super_L Super_R"
      ;;

    azerty)
      xmodmap -e "clear mod3"
      xmodmap -e "clear mod4"
#      xmodmap -e "clear control"
      xmodmap -e "add mod3 = Hyper_L"
      xmodmap -e "add mod4 = Super_L Super_R"
#      xmodmap -e "add control = Control_L"
      ;;

    *)
    exit 2
  esac
}

SetAlternateKey()
{
  regularKey="$1"
  simulatedKey="$2"
  keycodeNumber="$3"
  bepoSwitch="$4"

  # we setup xmodmap for use space as moddifier
  xmodmap -e "keycode ${keycodeNumber} = $simulatedKey" # we define the simulated switch
  xmodmap -e "keycode any = ${regularKey}" # we define the regular key

  # we execute xcape -e for space only at the first run of this scrit after reboot
  # if we don't do that, at each execution of this script, space become space++
  if [ ! -f ${TMPFILE} ] && [ ${regularKey} = "space" ]
  then
    xcape -e "${simulatedKey}=${regularKey}"
    echo "###SwitchKey.sh tmp file, please, do not delete!###" > ${TMPFILE}
  fi

  # we  execute  xcape -e for underscore only at the first run of this scipt where we switch bépo
  # if we don't do that, at each execution of this script, _ become _++ and this configuration don't
  # work after "setxkbmap fr bepo"
  if [ -z ${bepoSwitch} ] && [ ${regularKey} = "underscore" ]
  then
    xcape -e "${simulatedKey}=${regularKey}"
    echo "###SwitchKey.sh tmp file, please, do not delete!###" > ${TMPFILE}
    echo "True">> ${TMPFILE}
  fi
}

## MAIN PROGRAM
# we identify actual i3 configuration
 case ${ACTUALKEY} in
   bep) #  our actual keyboard configuration is in bépo
     if [ ! -f ${TMPFILE} ] #if a start the configuration is already in bépo
     then
       SwitchBepo
     else
       SwitchAzerty
     fi
     ;;

   lat|oss|*) # our actual keyboard configuration is in azerty or anythingelse
     # on passe le clavier en bepo
   SwitchBepo
     ;;

   *)
   exit 2
 esac

exit 0
