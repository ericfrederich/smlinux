#!/bin/bash
# This should do everything required to build & install under Ubuntu and update itself.
# Change line 7 to modify dependencies for other linux distributions.
# 2020-0613-1800

getdepends(){
	sudo apt install -y build-essential git python3 libaudiofile-dev libglew-dev libsdl2-dev
	}

domake(){
	make BETTERCAMERA=$BETTERCAMERA NODRAWINGDISTANCE=$NODRAWINGDISTANCE TEXTURE_FIX=$TEXTURE_FIX EXTERNAL_DATA=$EXTERNAL_DATA DISCORDRPC=$DISCORDRPC "$JOBS"
	}

dohd(){
	echo Getting HD Enhancements
	mkdir ~/sm64pc/build
	mkdir ~/sm64pc/build/us_pc
	mkdir ~/sm64pc/build/us_pc/res	
	cd ~/sm64pc/build/us_pc/res
	wget https://cdn.discordapp.com/attachments/711253314855108629/720369471105269831/upscaled-3.zip
	wget https://cdn.discordapp.com/attachments/711253314855108629/720369940317863946/upscaled-2.zip
	wget https://cdn.discordapp.com/attachments/711253314855108629/720370004171817080/upscaled-1.zip
	cd ~/sm64pc/enhancements
	wget https://cdn.discordapp.com/attachments/716459185230970880/719758031990030427/Old_School_HD_Mario_Model.zip 
	wget https://cdn.discordapp.com/attachments/716459185230970880/718990046442684456/hd_bowser.rar
	wget https://cdn.discordapp.com/attachments/716459185230970880/718674249631662120/3d_coin_v2.patch
	cd ..	
	cp -Rn actors actors.bak
	unzip -o enhancements/Old_School_HD_Mario_Model 
	unrar x -o+ enhancements/hd_bowser 
	git apply enhancements/3d_coin_v2.patch --ignore-whitespace
	}

scriptUpdate(){
if [ ! -f "~/.ubu-scriptUpdate" ]; then
	cd ${XDG_DATA_HOME:-$HOME/.local/share}/sm64pc
	if [ ! -f "${MAPFILE[0]}"/ubu-install.sh ]; then
		echo [2] Installing Script 		
		mv ${XDG_DATA_HOME:-$HOME/.local/share}/sm64pc ${XDG_DATA_HOME:-$HOME/.local/share}/sm64pc.baq
		git clone https://github.com/enigma9o7/ubu-install.git ${XDG_DATA_HOME:-$HOME/.local/share}/sm64pc
		cp -Rn ${XDG_DATA_HOME:-$HOME/.local/share}/sm64pc.baq/* ${XDG_DATA_HOME:-$HOME/.local/share}/sm64pc
		rm -rf ${XDG_DATA_HOME:-$HOME/.local/share}/sm64pc.baq
		touch ~/.ubu-scriptUpdate
		mv ${XDG_DATA_HOME:-$HOME/.local/share}/sm64pc/ubu-install.sh "${MAPFILE[0]}"/
		chmod +x "${MAPFILE[0]}"/ubu-install.sh
		exec ubu-install.sh "$@"
	else
		echo [2] Checking for Script Updates from Github...
		git fetch
		if [ "$(git diff HEAD origin/HEAD)" != "" ]; then
			git merge
			if [ ! -f ${XDG_DATA_HOME:-$HOME/.local/share}/sm64pc/ubu-install.sh ]; then
				echo "ERROR WTF!  Script Update Unsuccesful."
				echo "Try #help-desk if script udpates continue to fail"
			else
			echo 'mapfile -t -d: <<<"$PATH"
mv -f ${XDG_DATA_HOME:-$HOME/.local/share}/sm64pc/ubu-install.sh "${MAPFILE[0]}"/
chmod +x "${MAPFILE[0]}"/ubu-install.sh	
exec ubu-install.sh "$@"' > ~/ubu-scriptUpdate
			sudo chmod +x ~/ubu-scriptUpdate
			exec ~/ubu-scriptUpdate "$@"
			fi
		fi
	fi
fi
}

#Before we do anything real, make sure folders and installer config file exist, if not create them.

LAUNCH_DIR=$(pwd)
mapfile -t -d: <<<"$PATH"


if [ ! -f ${XDG_DATA_HOME:-$HOME/.local/share}/sm64pc/ubu-cfg.txt ]; then		
	echo Creating ${XDG_DATA_HOME:-$HOME/.local/share}/sm64pc/ubu-cfg.txt
	if [ ! -d ${XDG_DATA_HOME:-$HOME/.local/share} ]; then mkdir ${XDG_DATA_HOME:-$HOME/.local/share}
	fi
	if [ ! -d ${XDG_DATA_HOME:-$HOME/.local/share}/sm64pc ]; then mkdir ${XDG_DATA_HOME:-$HOME/.local/share}/sm64pc
	fi
	echo '#Script 
AutoUpdate=1
Branch=nightly
InstallHD=1
UpdateHD=0

#Make
BETTERCAMERA=1
NODRAWINGDISTANCE=1
TEXTURE_FIX=1
EXTERNAL_DATA=1
DISCORDRPC=1
RENDER_API=GL
#RENDER_API=GL_LEGACY
VERSION=us
#VERSION=jp
#VERSION=eu
JOBS=-j'> ${XDG_DATA_HOME:-$HOME/.local/share}/sm64pc/ubu-cfg.txt
	if(whiptail --title "Script and Make Options" --yesno "$(cat ~/.local/share/sm64pc/ubu-cfg.txt)" 23 40 --yes-button "Edit Options" --no-button "Proceed" --defaultno); then
	whiptail --msgbox "The config file will open in your default xdg editor.  When you exit your editor, script will continue.  Don't close the terminal window the script is currently running in while editing your config file.  In the future you will not be automatically prompted to edit this unless ubu-cfg.txt is missing, but you can always edit it manually in any editor before updating your build.  For most people, these options which include community enhancements are reccommended.  If you mess up the config file, delete and it will be recreated." 16 60
	xdg-open ${XDG_DATA_HOME:-$HOME/.local/share}/sm64pc/ubu-cfg.txt 
	fi
fi
source ${XDG_DATA_HOME:-$HOME/.local/share}/sm64pc/ubu-cfg.txt

if [ "$1" = "-u" ] || [ "$1" = "--update" ] ; then
	if ((AutoUpdate)); then scriptUpdate
	fi
	source ${XDG_DATA_HOME:-$HOME/.local/share}/sm64pc/ubu-cfg.txt
	cd ~/sm64pc
	echo Getting updates from Github...
	git checkout "$Branch"
	git fetch
	git merge

	if [ -d ~/sm64pc/build/us_pc/res ]; then
		echo Preserving Textures.
		mv ~/sm64pc/build/us_pc/res ~/sm64pc
	fi

	rm -rf build
	if [ "$2" = "--hd" ] || [ "$2" = "--HD" ] || (($UpdateHD)); then
		dohd
		mv ~/sm64pc/res ~/sm64pc/build/us_pc/res.bak
		echo Previous res folder saved as res.bak
	fi	
	echo Compiling...
	domake
	
	if [ -d ~/sm64pc/res ]; then
		echo Restoring Textures.
		mv ~/sm64pc/res ~/sm64pc/build/us_pc/res.bak
		cp -Rn ~/sm64pc/build/us_pc/res.bak/* ~/sm64pc/build/us_pc/res
	fi

	echo Update Complete.  Testing Application...
	~/sm64pc/build/us_pc/sm64.us.f3dex2e &disown
	sleep 10
	echo
	echo Script Done.  You may exit or close this terminal window.
	echo
	exit
fi

if [ "$1" = "--purge" ] ; then
	
	echo Note this does not remove any packages installed as build tools or dependencies.
	echo Remove those with your package manager.  Devel libraries can always safely be removed.
	echo This also does not remove or restore any prior sm64pc folders backed up if you 
	echo installed more that once.  Just delete those folders manually from any file manager.
	echo And of course you must delete this script itself from "${MAPFILE[0]}"
	rm -rf ~/sm64pc
	rm -rf ${XDG_DATA_HOME:-$HOME/.local/share}/sm64pc
	rm ${XDG_DATA_HOME:-$HOME/.local/share}/icons/sm64.*
	rm ${XDG_DATA_HOME:-$HOME/.local/share}/applications/sm64.desktop
	rm ${XDG_DESKTOP_DIR:-$HOME/Desktop}/sm64.desktop
        exit
fi

if [ ! -f "$1" ]; then
	
	echo "/-----------------------------------------------------------------------------\\"
	echo "|                                                                             |"
	echo "|First Install: ubu-install.sh <romfile>                                      |"
	echo "|                                                                             |"
	echo "|Examples:                                                                    |"
	echo "|       ./ubu-install.sh ~/roms/n64/sm64.z64                                  |"
	echo "|                         or                                                  |"
	echo "|       ./ubu-install.sh \"Super Mario 64 (U) [!].z64\"                         |"
	echo "|                                                                             |"
	echo "|Update: ubu-install.sh --update <options>                                    |" 
	echo "|Updates existing install to latest from github, preserving external textures.|"
	echo "| option --hd to also update community sourced upscale add-ons                |"
	echo "|                                                                             |"
	echo "|Purge:  ubu-install.sh --purge                                               |"                 
	echo "|Removes all traces of installation previously created by this script.        |"
	echo "|                                                                             |"
	echo "-------------------------------------------------------------------------------"
	echo	
	if [ -d ~/sm64pc ]; then
		echo "ERROR: You must specify --update or --purge"
	else echo "ERROR: No romfile specified."	
	fi
	echo
	exit
fi

echo
echo [1] Installing required build tools...
getdepends


if ((AutoUpdate)); then scriptUpdate
	fi
if [ -f "~/.ubu-scriptUpdate" ]; then rm ~/.ubu-scriptUpdate
fi
if [ -f ~/Downloads/ubu-install.sh ]; then
	mv ~/Downloads/ubu-install.sh ~/Downloads/ubu-install.old
fi


echo
echo [3] Downloading sm64pc source from github... 
if [ -d ~/sm64pc ]; then
	mv ~/sm64pc ~/sm64pc-"$(date -r ~/sm64pc +"%Y%m%d_%H%M%S")"
	echo Existing sm64pc directory renamed.  
fi
cd
git clone https://github.com/sm64pc/sm64pc.git -b "$Branch"
if [ ! -d ~/sm64pc ]; then
	echo "ERROR: Could not reach github.  "
	echo "Script Ending Incomplete.  Contact #Help-Desk."
	exit
fi
cd $LAUNCH_DIR
cp "$1" ~/sm64pc/baserom.us.z64 

if (($InstallHD)); then dohd
fi

echo
echo [4] Compiling...
cd ~/sm64pc
domake
if [ ! -f ~/sm64pc/build/us_pc/sm64.us.f3dex2e ]; then
	echo ERROR: You do not have the expected binary ~/sm64pc/build/us_pc/sm64.us.f3dex2e
	echo "Script Exiting incomplete.  Contact #help-desk"
	exit
fi

echo
echo [5] Checking ${XDG_DATA_HOME:-$HOME/.local/share}/icons for existing sm64 icon...
if [ ! -f ${XDG_DATA_HOME:-$HOME/.local/share}/icons/sm64.* ]; then
	echo WARNING: Icon for desktop shortcut not found!
	if [ ! -d $HOME/.local ]; then mkdir $HOME/.local
	fi
	if [ ! -d ${XDG_DATA_HOME:-$HOME/.local/share} ]; then mkdir ${XDG_DATA_HOME:-$HOME/.local/share}
	fi
	if [ ! -d ${XDG_DATA_HOME:-$HOME/.local/share}/icons ]; then mkdir ${XDG_DATA_HOME:-$HOME/.local/share}/icons
	fi
	if [ ! -d ${XDG_DATA_HOME:-$HOME/.local/share}/applications ]; then mkdir ${XDG_DATA_HOME:-$HOME/.local/share}/applications
	fi
	cp ~/sm64pc/textures/segment2/segment2.05A00.rgba16.png ${XDG_DATA_HOME:-$HOME/.local/share}/icons/sm64.png
	echo 16x16 image from ROM used.  Reccommend replacing with higher resolution.
fi

echo
echo [6] Checking ${XDG_DATA_HOME:-$HOME/.local/share}/applications for Desktop Shortcut
if [ ! -f ${XDG_DATA_HOME:-$HOME/.local/share}/applications/sm64.desktop ]; then
	echo Creating Menu Entry and Desktop Shortcut...
	echo '[Desktop Entry]
Encoding=UTF-8
Type=Application
Name=Super Mario 64
StartupNotify=false
Categories=Game;'>${XDG_DATA_HOME:-$HOME/.local/share}/applications/sm64.desktop
echo Exec=~/sm64pc/build/us_pc/sm64.us.f3dex2e --cheats>>${XDG_DATA_HOME:-$HOME/.local/share}/applications/sm64.desktop
echo Icon=${XDG_DATA_HOME:-$HOME/.local/share}/icons/sm64.png >>${XDG_DATA_HOME:-$HOME/.local/share}/applications/sm64.desktop
echo Path=~/sm64pc/build/us_pc >>${XDG_DATA_HOME:-$HOME/.local/share}/applications/sm64.desktop
	cp ${XDG_DATA_HOME:-$HOME/.local/share}/applications/sm64.desktop ${XDG_DESKTOP_DIR:-$HOME/Desktop}
fi

echo [7] Build Succesful!  Testing Application Launch Via Shortcut...
gtk-launch sm64&disown
sleep 10
echo
echo Script Done.  You may exit or close this terminal window.
echo