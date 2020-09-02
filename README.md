&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; [Click Here to View](https://raw.githubusercontent.com/enigma9o7/smlinux/master/smlinux) &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; [Right Click Here - Save Link As to Download](https://raw.githubusercontent.com/enigma9o7/smlinux/master/smlinux) 

<img src=https://github.com/enigma9o7/smlinux/raw/screenshot/MarioPC-small.png>
<img src=https://github.com/enigma9o7/smlinux/raw/screenshot/screenshot.jpg>
<img src=https://github.com/enigma9o7/smlinux/raw/screenshot/screenshot1.jpg>

# &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; Super  Mario  Linux  Build  Install  Update
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; [Click Here to View](https://raw.githubusercontent.com/enigma9o7/smlinux/master/smlinux) &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; [Right Click Here - Save Link As to Download](https://raw.githubusercontent.com/enigma9o7/smlinux/master/smlinux) 

# 
1. Installs Required Packages (build tools & dependencies)
2. Installs latest version of itself to user path 
3. Clones (downloads) sm64 source repository from Github
4. Extract Assets from ROM and prepares for use
5. Optionally applies community sourced upscale modifications 
6. Makes (compiles and links) into binary
7. Creates Menu Entry & Desktop Shortcut
8. Launches Super Mario 64 on your Personal Computer or Android Device!

...and! you can use it again later to quickly rebuild and sync to the latest updates from github.
 

First Time Usage:      
                
	chmod +x smlinux
	./smlinux <romfile>
Examples: 

 	./smlinux "Super Mario 64 (U) [!].z64"
		      or 
	./smlinux ~/roms/n64/sm64.z64

That's Everything. That's all you have to do..
You'll be asked sudo password to install build tools at the beginning, then it will update and intsall itself to the first directory in your path (or create ~/bin if nothing available), and prompt you to approve (or change) the reccommended options before your build starts, then will run as user unattended and before the time you finish reading the FAQ you will hear "It's me, Mario!".  
(**Do not run script as root; you will be prompted for sudo password automatically if needed.**)

You must provide your own legally backed up rom file in Z64 (Big Endian) format. 

If for some reason the make pauses or hangs, perhaps on single core cpu or system with low memory, then set JOBS=-j1. Without the 1, this switch makes make run multiple jobs at once which speeds up the build process on PCs with multiple cores and plenty of memory, but occasionally causes issues on under-powered systems (that can still run the game just fine).

Note the script installs itself as 'smlinux' to the first directory in your path, usually something like ~/bin or ~/Applications/.bin. After first running what you download, you can delete it, and just type 'smlinux update' from anywhere when you're ready to rebuild or update.

# Frequently Asked Questions

* [<strong>What repository should I use?</strong>](#what-repository-should-i-use)
* [<strong>What branch should I use?</strong>](#what-branch-should-i-use)
* [<strong>When to use RENDER_API=GL_LEGACY?</strong>](#when-to-use-render_apigl_legacy)
* [<strong>What does the InstallHD=1 Script option do?</strong>](#what-does-the-installhd1-script-option-do)
* [<strong>How to update, rebuild, or change build options later?</strong>](#how-to-update-rebuild-or-change-build-options-later)
* [<strong>How to I configure options like controllers, camera, rumble, etc?</strong>](#how-to-i-configure-options-like-controllers-camera-rumble-etc)
* [<strong>Where are my configuration files and saved games stored?</strong>](#where-are-my-configuration-files-and-saved-games-stored)
* [<strong>Are there any cheats?</strong>](#are-there-any-cheats)
* [<strong>How do I apply external textures?</strong>](#how-do-i-apply-external-textures)
* [<strong>How to apply a patch?</strong>](#how-to-apply-a-patch)
* [<strong>How to remove a patch?</strong>](#how-to-remove-a-patch)
* [<strong>What about distros other than Ubuntu/Debian?</strong>](#what-about-distros-other-than-ubuntudebian)
* [<strong>How do I create my rom file?</strong>](#how-do-i-create-my-rom-file)
* [<strong>How do I remove everything the script created during install?</strong>](#how-do-i-remove-everything-the-script-created-during-install)
* [<strong>How do I tell smlinux to download sm64 repositories to a folder other than home?</strong>](#how-do-i-tell-smlinux-to-download-sm64-repositories-to-a-folder-other-than-home)

## **What repository should I use?**
If you want to build for PC, the official repo from the team who decompiled the rom, sm64-port, offers the cleanest code and duplication of N64, with currently very few add-ons available.  The unofficial forks, sm64ex and sm64nx, include enhancements and support for many add-ons (which are optional on sm64ex).  sm64ex offers the most flexibility, but you are encouraged to build more than one and try for yourself.  Further forks from there offer other changes, such as render96ex with added Luigi Keys, or sm64-coop for a 2 player network mode.

If you want to build for **Android** then use sm64-port-android-base

## **What branch should I use?**

All repos offer master as the main branch.  With sm6ex you can set BRANCH=nightly which is under constant development.  If nightly works for you, I'd reccommend it as it is the most updated, but if a recent change causes build failure or other problems, use the more stable master.  For sm64ex-coop, use BRANCH=coop.  For sm64-port-android-base, I reccommend BRANCH=sm64ex_nightly. 

## **When to use RENDER_API=GL_LEGACY?** 
*only applies to sm64pc/sm64ex fork*

For old video cards that support OpenGL 1.1 but not 2.1 (from year 200X).  Check your OpenGL version with the following command: 
	
	glxinfo | grep "OpenGL version"
 
If 1.1-2.0, you must use the legacy renderer.  For 2.1 or greater, standard GL renderer is reccommended, although some old computers that do support 2.1 may perform better with the legacy renderer.
  

## **What does the InstallHD=1 Script option do?**

This will modify your source with the repo-provided 60fps patch and from #modding-releases HD Mario (Old School V2) and HD Bowser, and on both sm64-port and sm64pc/sm6ex the 3D Coin Patch (V2) will also be applied.
  
Additionally, on the sm64pc/sm64ex fork upscaled textures will be added to your build from the Cleaner Aesthetics github repo, and hq sounds from MapnAnon's github release.
*Note that precaching these textures will make the game use more memory and increase initial startup time, but may be necessary for some computers.*

On the sm64nx fork only, 60fps is already default, and with InstallHD in addition to the models and textures mentioned above, a few other add-ons are obtained which can be enabled from the in-game menu if you prefer, including SGI models and HD Luigi.

Some of these addons require files remaining available in discord or github, so not gauranteed to work.  I may periodically add or change what's included with this option as new mods are released.  


## **How to update, rebuild, or change build options later?**
    
	smlinux update <options>
For example: 
 
	smlinux update
	       or
	smlinux update --updatehd
	       or
	smlinux update --config
		or
	smlinux update --sgi

Updates existing install to latest from github while retaining custom textures and addons.  If updated source fails to build, restores previous build.

You can also use this option to rebuild after you apply patches or edit your source or source assets like actors manually.

Note --config is only needed if CONFIG=0 in your config file, otherwise it will come up automatically.

Note --updatehd only needs to be applied if UpdateHD=0 in config file, and what was initally installed with the InstallHD option has changed/updated since you last built, or if you wish to add HD add-ons to an existing build that doesn't have them.

If you want to save your existing build, rename it (anything) before running the update, for example: 
 
	mv ~/sm64pc/build/us_pc ~/sm64pc/build/firstbuild

Note smlinux automatically stores one previous build by adding the suffix .old to its foldername (and restores it if your update fails to build.

## **How to I configure options like controllers, camera, rumble, etc?**
*only applies to sm64pc/sm64ex fork*

Pause then press R with controller or R_Shift with keyboard. For the controller settings, it is recommended to keep the first column for keyboard controls and using the middle for controller. Use the third column if you want additional keys/buttons assigned to the same function, or for mouse buttons. Be sure to map something to L for use with the camera or cheats. I personally enable mouse control for camera and turn up my aggression and pan up to 100. 

You can also just edit the configuration file with a text editor.

## **Where are my configuration files and saved games stored?**

~/.local/share/sm64pc smlinux and sm64pc/ex master  
~/.local/share/sm64ex sm64ex nightly
~/.local/share/render96ex Render96ex
~/.local/share/sm64ex-coop sm64ex-coop
~/.local/share/sm64-port sm64-port *only if launched with shortcut*    
~/.local/share/sm64nx sm64nx *script creates links to game dir*  

## **Are there any cheats?**
*only applies to sm64pc/sm64ex and sm64nx based builds*

Cheats are built in and enabled automatically if launched from shortcut and available in options menu.

## **How do I apply external textures?**

sm64pc/sm64ex:  
Just get the appropriate texture pack, then put the zip into your "res" folder in build/us_pc and the next time you run the game it'll use those textures automatically. (You do this after build.) The zip file must contain a "gfx" and/or "sound" folder within it. If it's another format, you must create a folder named build/us_pc/res/gfx put the unpacked archive in there. If you upgraded from a version of the game prior to 7-June, this is a new method and your old files need to be moved from "res" into the "gfx" sub-directory, except the old sound folder which can be deleted. Do not move or remove base.zip, it should remain in "res" as fallback.
  
sm64nx:  
Just get the appropriate texture pack, then put the pak into your "romfs" folder in build/us_pc and the next time you run the game it'll use those textures automatically. (You do this after build.) Do not move or remove !!base.pak, it should remain in "romfs" as fallback.

## **How to apply a patch?**
*change path from sm64pc to sm64-port or sm64ex for newer repos*

Put the patch file into ~/sm64pc/enhancements (or specify the path differently when applying):
   
	cd ~/sm64pc
	git apply enhancements/filename.patch
	smlinux update

## **How to remove a patch?** 
*change path from sm64pc to sm64-port or sm64ex for newer repos*
   
	cd ~/sm64pc
	git apply -R enhancements/filename.patch
	smlinux update


## **What about distros other than Ubuntu/Debian?**
*Tested on Bodhi 5.1,32 & 64-bit, so should work as-is on recent Ubuntu/debian, Arch confirmed on ex/nx, others unconfirmed.*

Change your Linux=parameter during first install to one that works with your distro such as those listed below, or just install dependencies first and run smlinux with Linux="" in settings (or just ignore the error from apt).  smlinux only installs dependendencies automatically during the very first installation.  If your distro needs additional dependencies not listed here, please let me know so I can add them.

Some build targets depend on an additional package not listed below.  Android builds require the android-sdk package, while sm64nx requires g++-8 or higher.  Installation when needed will only be automatically attempted if apt is present, other distros will need to install those packages manually.  If gcc --version does not report 8 or newer when building sm64nx, smlinux will attempt first to install gcc-9 then if unsuccesful gcc-8.  (Note Ubuntu 20.04 build-essential provides gcc9.3, whereas for 18.04 its gcc7.5.)  

Arch: 
    
	sudo pacman -S base-devel python audiofile sdl2 glew python-zstandard python-pip zstd
Debian / Ubuntu:  

	sudo apt install -y build-essential git python3 libaudiofile-dev libglew-dev libsdl2-dev binutils libusb-1.0-0-dev libzstd-dev python3-pip
Fedora  / Red Hat:

	sudo dnf install make gcc python3 audiofile-devel glew-devel SDL2-devel zstd
openSuSE:

	sudo zypper in gcc make python3 libaudiofile1 glew-devel libSDL2-devel
Solus:
	
	sudo eopkg install make gcc python3 audiofile-devel glew-devel sdl2-devel

Void: 

	sudo xbps-install -S base-devel python3 audiofile-devel SDL2-devel glew-devel zstd 
	


## **How do I create my rom file?**

Backup your cartridge to z64 format with a cartridge dumper such as a Retrode2, or buy for Wii U Virtual Console and extract image using homebrew tools.  
 &nbsp; &nbsp; [Dragonbox Store](https://www.dragonbox.de/en/accessories/cartridge-dumper/retrode2-with-all-plugins) &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; [Stoneage Gamer](https://stoneagegamer.com/retrode-2-cart-reader-rom-dumper-for-super-nintendo-genesis-more.html) &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; 
[Nintendo Wii U Store](https://www.nintendo.com/games/detail/super-mario-64-wii-u) &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; [Virtual Console ROM Claim Software]( https://github.com/JanErikGunnar/vcromclaim)
## **How do I remove everything the script created during install?**
 
	smlinux purge
This erases everything created running smlinux including automatically created game saves and config files.
This does not remove any packages installed as build tools or dependencies. Remove those with your package manager.
(Development libraries can always safely be removed if you don't plan to build again, and binaries will still run.)
This also does not restore or remove any prior sm64 folders backed up if you ran full install more that once (versus update);
delete those folders manually from any file manager.
## **How do I tell smlinux to download sm64 repositories to a folder other than home?**

	smlinux config
Set BASEPATH= to any existing path that you have permission to write to. 

&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; [Click Here to View](https://raw.githubusercontent.com/enigma9o7/smlinux/master/smlinux) &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; [Right Click Here - Save Link As to Download](https://raw.githubusercontent.com/enigma9o7/smlinux/master/smlinux) 
