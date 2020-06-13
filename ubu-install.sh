# This should do everything required to build & install under Ubuntu.
# Change optional make parameters on line 8 if desired, including:
# BETTERCAMERA=1 NODRAWINGDISTANCE=1 TEXTURE_FIX=1 EXTERNAL_DATA=1 RENDER_API=GL_LEGACY VERSION=jp DISCORDRPC=1 -j
# Change line 12 to modify dependencies for other linux distributions.
# 2020-0613-test49

domake(){
	make BETTERCAMERA=1 NODRAWINGDISTANCE=1 TEXTURE_FIX=1 EXTERNAL_DATA=1 DISCORDRPC=1 -j
	}

getdepends(){
	sudo apt install -y build-essential git python3 libaudiofile-dev libglew-dev libsdl2-dev
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

if [ "$1" = "-u" ] || [ "$1" = "--update" ] ; then

	cd ~/sm64pc
	echo Getting updates from Github...
	git checkout "$2"
	git fetch
	git merge

	if [ -d ~/sm64pc/build/us_pc/res ]; then
		echo Preserving Textures.
		mv ~/sm64pc/build/us_pc/res ~/sm64pc
	fi

	rm -rf build
	if [ "$3" = "--hd" ] || [ "$3" = "--HD" ] || [ "$2" = "--hd" ] || [ "$2" = "--HD" ]; then
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
	rm -rf ~/sm64pc
	rm -rf ${XDG_DATA_HOME:-$HOME/.local/share}/sm64pc
	rm ${XDG_DATA_HOME:-$HOME/.local/share}/icons/sm64.*
	rm ${XDG_DATA_HOME:-$HOME/.local/share}/applications/sm64.desktop
	rm ${XDG_DESKTOP_DIR:-$HOME/Desktop}/sm64.desktop
        # This section from before I used xdg-paths, will eventually be removed from script 
	# but I'm leaving it here a little while incase someobdy uses the new script and wants to wipe
	# the old data and it had a different path cuz different language or distro.
	rm -rf ~/.local/share/sm64pc
	rm ~/.local/share/icons/sm64.*
	rm ~/.local/share/applications/sm64.desktop
	rm ~/Desktop/sm64.desktop
	exit
fi

if [ ! -f "$1" ]||[ "$2" == "" ] ; then
	
	echo "/-----------------------------------------------------------------------------\\"
	echo "|                                                                             |"
	echo "|First Install: ubu-install.sh <romfile> <branch> <options>                   |"
	echo "|  option --hd for high resolution upscale (Mario, Bowser, Coins, Textures)   |"
	echo "|                                                                             |"
	echo "|Examples:                                                                    |"
	echo "|       ./ubu-install.sh ~/roms/n64/sm64.z64 master                           |"
	echo "|                         or                                                  |"
	echo "|       ./ubu-install.sh \"Super Mario 64 (U) [!].z64\" nightly --hd            |"
	echo "|                                                                             |"
	echo "|Update: ubu-install.sh --update <branch> <options>                           |" 
	echo "|Updates existing install to latest from github, preserving external textures.|"
	echo "|                                                                             |"
	echo "|Purge:  ubu-install.sh --purge                                               |"                 
	echo "|Removes all traces of installation previously created by this script.        |"
	echo "|                                                                             |"
	echo "-------------------------------------------------------------------------------"
	echo	
	if [ -f "$1" ]; then
		echo "ERROR: You must specify a branch after the filename, i.e. nightly."
	elif [ -d ~/sm64pc ]; then
		echo "ERROR: You must specify --update or --purge"
	else echo "ERROR: No romfile specified."	
	fi
	echo
	exit
fi

echo
echo [1] Installing required build tools...
getdepends
cp "$1" ~/baserom.us.z64

echo
echo [2] Downloading source from github... 
if [ -d ~/sm64pc ]; then
	mv ~/sm64pc ~/sm64pc-"$(date -r ~/sm64pc +"%Y%m%d_%H%M%S")"
	echo Existing sm64pc directory renamed.  
fi
cd
git clone https://github.com/sm64pc/sm64pc.git -b "$2"
	if [ ! -d ~/sm64pc ]; then
		echo "ERROR: Could not reach github.  "
		echo "Script Ending Incomplete.  Contact #Help-Desk."
		exit
	fi
mv ~/baserom.us.z64 ~/sm64pc/

if [ "$3" = "--hd" ] || [ "$3" = "--HD" ]; then
	dohd
fi

echo
echo [3] Compiling...
cd ~/sm64pc
domake
if [ ! -f ~/sm64pc/build/us_pc/sm64.us.f3dex2e ]; then
	echo ERROR: You do not have the expected binary ~/sm64pc/build/us_pc/sm64.us.f3dex2e
	echo "Script Exiting incomplete.  Contact #help-desk"
	exit
fi

echo
echo [4] Checking ${XDG_DATA_HOME:-$HOME/.local/share}/icons for existing sm64 icon...
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
echo [5] Checking ${XDG_DATA_HOME:-$HOME/.local/share}/applications for Desktop Shortcut
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

echo [6] Build Succesful!  Testing Application Launch Via Shortcut...
gtk-launch sm64&disown
sleep 10
echo
echo Script Done.  You may exit or close this terminal window.
echo