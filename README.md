&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; [Click to View](https://raw.githubusercontent.com/enigma9o7/smlinux/master/smlinux) &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; [Right Click - Save Link As to Download](https://raw.githubusercontent.com/enigma9o7/smlinux/master/smlinux) 

<img src=https://github.com/enigma9o7/smlinux/raw/screenshot/screenshot.jpg>
<img src=https://github.com/enigma9o7/smlinux/raw/screenshot/screenshot1.jpg>

# &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; Super  Mario  Linux  Build  Install  Update
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; [Click to View](https://raw.githubusercontent.com/enigma9o7/smlinux/master/smlinux) &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; [Right Click - Save Link As to Download](https://raw.githubusercontent.com/enigma9o7/smlinux/master/smlinux) 

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

If for some reason the make pauses or hangs, perhaps on single core cpu or system with low memory, then change JOBS to -j1. Without the 1, this switch makes make run multiple jobs at once which speeds up the build process on PCs with multiple cores and plenty of memory, but occasionally causes issues on under-powered systems (that can still run the game just fine).

Note the script installs itself as 'smlinux' to the first directory in your path, usually something like ~/bin or ~/Applications/.bin. After first running what you download, you can delete it, and just type 'smlinux update' from anywhere when you're ready to rebuild or update.

# Frequently Asked Questions

## **What repository should I use?**
If you want to build for PC, the official repo, sm64-port/sm64-port, offers the cleanest code and duplication of N64, with currently very few add-ons available.  The unofficial forks, sm64ex and sm64nx, include enhancements and support for many add-ons (which are optional on sm64ex).  sm64ex offers the most flexibility, but you are encouraged to build more than one and try for yourself.

If you want to build for **Android** then set repo=sm64-port-android-base

## **What branch should I use?**

All repos offer master as primary.  sm6ex also offers nightly which is under constant development.  If nightly works for you, I'd reccommend it as it is the most updated, but if a recent change causes build failure or other problems, use the more stable master.  

## **When to use RENDER_API=GL_LEGACY?** 
*only applies to sm64pc/sm64ex fork*

For old video cards with OpenGL 1.2 or 1.3 but no 2.1 support (from year 200X).  Check your OpenGL version with the following command: 
	
	glxinfo | grep "OpenGL version"
 
2.1 or higher, do not use this option.  
2.0 Does this version even exist in the wild? If so, try normal, then legacy, report back!  
1.2/1.3/1.4 This build option was made for you! Remove the # commenting that option in smlinuxcfg.txt.  
1.0/1.1 Sorry.  

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
	smlinux update --hd
	       or
	smlinux update --config

Updates existing install to latest from github while retaining custom textures and addons.  If updated build fails, keeps previous build.

You can also use this option to rebuild after you apply patches or edit your source or source assets like actors manually.
Note --hd only needs to be applied once, not with every update (unless what's included with hd has changed in new version of script).

If you want to save your existing build, rename it (anything) before running the update, for example: 
 

	mv ~/sm64pc/build ~/sm64pc/build-old

## **How to I configure options like controllers, camera, rumble, etc?**
*only applies to sm64pc/sm64ex fork*

Pause then press R with controller or R_Shift with keyboard. For the controller settings, it is recommended to keep the first column for keyboard controls and using the middle for controller. Use the third column if you want additional keys/buttons assigned to the same function, or for mouse buttons. Be sure to map something to L for use with the camera or cheats. I personally enable mouse control for camera and turn up my aggression and pan up to 100. 

You can also just edit the configuration file with a text editor.

## **Where are my configuration files and saved games stored?**

~/.local/share/sm64pc smlinux and sm64pc master  
~/.local/share/sm64ex  sm64ex    
~/.local/share/sm64-port sm64-port *only if launched with shortcut*    
~/.local/share/sm64nx sm64nx *script creates links to game dir*  

## **Are there any cheats?**
*only applies to sm64pc/sm64ex and sm64nx forks*

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
*Tested on Bodhi 5.1,32 & 64-bit, so should work as-is on recent Ubuntu/debian, Arch confirmed on ex/nx, others unconfirmed on all forks.*

Change your Linux=paramater during first install to one that works with your distro such as the following, or just install dependencies first then run smlinux script, either with Linux="" in settings or just ignoring any error regarding apt.

Arch: 
    
	sudo pacman -S base-devel python audiofile sdl2 glew python-zstandard python-pip 
Debian / Ubuntu:  

	sudo apt install -y build-essential git python3 libaudiofile-dev libglew-dev libsdl2-dev binutils libusb-1.0-0-dev libzstd-dev python3-pip p7zip-full
Fedora  / Red Hat:

	sudo dnf install make gcc python3 audiofile-devel glew-devel SDL2-devel
openSuSE:

	sudo zypper in gcc make python3 libaudiofile1 glew-devel libSDL2-devel
Solus:
	
	sudo eopkg install make gcc python3 audiofile-devel glew-devel sdl2-devel

Void: 

	sudo xbps-install -S base-devel python3 audiofile-devel SDL2-devel glew-devel
	


## **How do I create my rom file?**

Backup your cartridge to z64 format with a cartridge dumper such as a Retrode2, or buy for Wii U Virtual Console and extract image using homebrew tools.  
 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; [Dragonbox Store](https://www.dragonbox.de/en/accessories/cartridge-dumper/retrode2-with-all-plugins) &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; [Stoneage Gamer](https://stoneagegamer.com/retrode-2-cart-reader-rom-dumper-for-super-nintendo-genesis-more.html) &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; 
[Nintendo Wii U Store](https://www.nintendo.com/games/detail/super-mario-64-wii-u) &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; [Virtual Console ROM Claim Software]( https://github.com/JanErikGunnar/vcromclaim)
## **How do I remove everything the script created during install?**
 
	smlinux purge
This erases everything created running smlinux including automatically created game saves and config files.
This does not remove any packages installed as build tools or dependencies. Remove those with your package manager.
(Development libraries can always safely be removed if you don't plan to build again, and binaries will still run.)
This also does not restore or remove any prior sm64 folders backed up if you ran full install more that once (versus update);
delete those folders manually from any file manager.

&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; [Click to View](https://raw.githubusercontent.com/enigma9o7/smlinux/master/smlinux) &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; [Right Click - Save Link As to Download](https://raw.githubusercontent.com/enigma9o7/smlinux/master/smlinux)
