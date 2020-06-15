Super Mario Linux Build Install Update
[1] Installs Required Packages (build tools & dependencies) 
[2] Installs latest version of itself to user path from Github
[3] Clones (downloads) sm64pc source repository from Github
[4] Optionally applies community sourced upscale modifications from Discord
[5] Makes (compiles and links) into binary
[6] Creates Menu Entry & Desktop Shortcut
[7] Launches Super Mario 64 on your Personal Computer!
...and! you can use it again later to quickly rebuild and sync to the latest updates from github.
 

First Time Usage:      chmod +x smlinux
			./smlinux <romfile>
Examples: 
 ./smlinux "Super Mario 64 (U) [!].z64"
			or 
 ./smlinux ~/roms/n64/sm64.z64 master
That's Everything. That's all you have to do..
You'll be asked sudo password to install build tools at the beginning, and to confirm reccommended options on edit before your start, then will run as user unattended and before the time you finish reading the FAQ you will hear "It's me, Mario!".
(Do not run script as root; you will be prompted for sudo password automatically if needed.)
By default, builds with all optional enhancements enabled; If you want to remove any, you will be prompted to edit config during first install.

Be sure when you backup your N64 cartridge to use the Z64 format. You must provide your own legally backed up rom file. Currently only US & JP versions have sound. If you want German or French text, and sound at the same time, you'll have to wait until the pc-port adds multilingual support, then those languages plus Spanish and every language could be supported with community effort.

If for some reason the make pauses or hangs, perhaps on single core cpu or system with low memory, then remove -j from line 8. This switch makes make run multiple jobs at once which speeds up the build process on PCs with multiple cores and plenty of memory, but occasionally causes issues on under-powered systems (that can run the game just fine).

Note the script installs itself as 'smlinux' to the first directory in your path, usually something like ~/bin or ~/Applications/.bin. After first running what you download, you can delete it, and just type 'smlinux update' from anywhere when you're ready to rebuild.

Frequently Asked Questions

What branch should I use?

There are at least two active branches. master, which hasn't been updated in the past couple weeks, and nightly, which is regularly updated and has features and fixes not included in master. At this time nightly is strongly recommended, however there's always a chance a recent code could break something.

When to use RENDER_API=GL_LEGACY? 

For video cards with old OpenGL version 1.2 or 1.3 (from year 200X). Check your OpenGL version with the following command: 
 
glxinfo | grep "OpenGL version"
2.1 or higher, don't add this option.
2.0 Does this version even exist in the wild? If so, try normal, then legacy, report back!.
1.2/1.3 This build option was made for you! Remove the # commenting that option in smlinuxcfg.txt.
1.0/1.1 Really? Sorry. Can you even run glxgears?

What does the InstallHD=1 Script option do?

This will modify your source with some community provided high resolution actors and patches and add a texture pack to your build.
From #modding-releases HD Bowser, HD Mario (Old School V2) and the 3D Coin Patch (V2)
From #upscaled-textures Cleaner Aesthetics Texture Pack
From #user-submitted-content Mario Icon
This depends on those files remaining available in discord, so if the source goes away, this option will not work anymore. 
I may periodically add or change what's included with this option as new mods are released.
Note that precaching these textures will make the game use more memory and increase initial startup time.

How to update, rebuild, or change build options later?

smlinux update <options>
For example: 
 smlinux update
or
 smlinux update --hd
Updates existing install to latest from github while retaining custom textures.

You can also use this option to rebuild if you edit your source files or change source assets like actors manually.
Note --hd only needs to be applied once, not with every update (unless what's included with hd has changed in new version of script).

If you want to save your existing build, rename it (anything) before running the update, for example: 
 mv ~/sm64pc/build ~/sm64pc/build-old

How to I configure options like controllers, camera, rumble, etc?

Pause then press R with controller or R_Shift with keyboard. For the controller settings, it is recommended to keep the first column for keyboard controls and using the middle for controller. Use the third column if you want additional keys/buttons assigned to the same function, or for mouse buttons. Be sure to map something to L for use with the camera or cheats. I personally enable mouse control for camera and turn up my aggression and pan up to 100. 

You can also just edit the configuration file with a text editor.

Where are my configuration files and saved games stored?

~/.local/share/sm64pc

Are there any cheats?

Cheats are built in and enabled automatically if launched from shortcut (as of 6/6) and available at the bottom of the options menu.
Alternatively, from within the game, pause then press ... (three dots) or LLL on controller before entering the options menu.

How do I apply external textures?

Just get the appropriate texture pack, then put the zip into your "res" folder in build/us_pc and the next time you run the game it'll use those textures automatically. (You do this after build.) The zip file must contain a "gfx" and/or "sound" folder within it. If it's another format, you must create a folder named build/us_pc/res/gfx put the unpacked archive in there. If you upgraded from a version of the game prior to 7-June, this is a new method and your old files need to be moved from "res" into the "gfx" sub-directory, except the old sound folder which can be deleted. Do not move or remove base.zip, it muse remain in "res" as fallback.

How to apply a patch?

Put the patch file into ~/sm64pc/enhancements (or specify the path differently when applying): 
 
cd ~/sm64pc
git apply enhancements/filename.patch
~/Downloads/smlinux update
How to remove a patch? 
 
cd ~/sm64pc
git apply -R enhancements/filename.patch
~/Downloads/smlinux update
Why is the menu/shortcut icon blocky?

Its 16x16 and comes from your rom. Find a high quality public domain transparent icon and replace ~/.local/share/icons/sm64.png

What about distros other than Ubuntu/Debian?
Tested on Bodhi 5.1,32 & 64-bit, so should work as-is on recent Ubuntu/debian, others untested. 

If script doesn't work as is, install dependencies first then rerun script, ignoring any error regarding apt.
Arch: sudo pacman -S base-devel python audiofile sdl2 glew
Debian:  sudo apt-get install build-essential git python3 libaudiofile-dev libglew-dev libsdl2-dev
Fedora: sudo dnf install make gcc python3 audiofile-devel glew-devel SDL2-devel
Void: sudo xbps-install -S base-devel python3 audiofile-devel SDL2-devel glew-devel
If you wish to modify the config file for others with your distro, set the $Linux= with the above or what works for you.

How do I create my rom file?

Backup your cartridge to z64 format with something like Retrode2 https://www.dragonbox.de/en/accessories ... ll-plugins

How do I remove everything the script created during install? 
 
smlinux purge
This erases everything created running smlinux including automatically created game saves and config files.
This does not remove any packages installed as build tools or dependencies. Remove those with your package manager.
(Development libraries can always safely be removed if you don't plan to build again, and binaries will still run.)
This also does not restore or remove any prior sm64pc folders backed up if you ran the install script more that once;
delete those folders manually from any file manager.

What could go wrong?

If you already have a sm64pc folder and put this script there and tried to install from there, that'd probably confuse it. It assumes this is first install and that it doesn't exist already. Don't do that unless you're running --update which can be called from anywhere.

If you make with eu rom, you won't get sound. This is a known bug with the port. Sorry. 
