# Things done after install ubuntu 24.04

```
sudo pro attach <mycredential>
sudo apt update
```

The installation of gnome-tweaks is optional for me
```
sudo apt install gnome-tweaks
```

### Increase the text-scaling factor
For a 13 inch laptop
```
gsettings set org.gnome.desktop.interface text-scaling-factor 1.1300
```

# dark theme
The next configurations can be done with the ubuntu GUI. But, I prefer do this from
command line because is faster and less  time consuming on testing until arrive
to the state desired.
```
gsettings set org.gnome.Settings last-panel 'background'
gsettings set org.gnome.Settings window-state (980, 640, false)
gsettings set org.gnome.desktop.interface color-scheme 'prefer-dark'
gsettings set org.gnome.desktop.interface gtk-theme 'Yaru-blue-dark'
gsettings set org.gnome.desktop.interface icon-theme 'Yaru-blue'
```

### for small icon size
```
gsettings set org.gnome.shell.extensions.ding icon-size 'small'
```

### The pannel
Attach the pannel at bottom with size of 40
```
gsettings set org.gnome.shell.extensions.dash-to-dock dash-max-icon-size 40
gsettings set org.gnome.shell.extensions.dash-to-dock dock-position 'BOTTOM'
gsettings set org.gnome.shell.extensions.dash-to-dock extend-height false
gsettings set org.gnome.shell.extensions.dash-to-dock show-mounts false
gsettings set org.gnome.shell.extensions.dash-to-dock show-trash false
```

### Night mode
```
gsettings set org.gnome.settings-daemon.plugins.color night-light-enabled true
gsettings set org.gnome.settings-daemon.plugins.color night-light-schedule-from 5.0
gsettings set org.gnome.settings-daemon.plugins.color night-light-schedule-to 4.59
gsettings set org.gnome.settings-daemon.plugins.color night-light-temperature 3850
```

The commands used to change the values can be identified comparing the
configuration original state with a modified state as shown bellow:
```
gsettings list-recursively > file1
# do some change using the GUI
gsettings list-recursively > file2
diff file1 file2
```

### shortscuts
I define my favorites shortscuts manually, for example:
<alt>e for open firefox  
<alt>w for minimize or hide window  
<ctrl><alt>f for open the home folder  

### install tree for visualize files
```
sudo apt install tree
```

### Files permissions
Copy personal files, and give to them the right permissions for directories in
work directory, be careful with the executables.
```
find . -type d -exec chmod -fv 755 {} \;
# for files in home directory
find . -type f -exec chmod -fv 644 {} \;
```

### Stow
A symlink farm for managing the installation of multiple software packages in
the same directory tree
```
sudo apt install stow
```

### Install the multimedia
```
sudo apt install ubuntu-restricted-extras
sudo apt install mplayer 
# sudo snap install vlc #(optional)
sudo gdebi vdhcoapp-linux-x86_64.deb # for the video downloader helper plugin
# Download the Video Downloader
```

### Git and repo config
```
sudo apt install ssh
sudo apt install git
git config --global user.name "username"
git config --global user.email "somemail@gmail.com"
ssh-keygen -t rsa -C "somemail@gmail.com"
```

### Gdbi for .deb installations
```
sudo apt install gdebi
# sudo gdebi expressvpn_3.76.0.4-1_amd64.deb #(optional)
```

# Chrome
```
sudo gdebi google-chrome-stable_current_amd64.deb
```


### instaling Curl
```
sudo apt install curl
```

### the gnome-shell extension manager 
```
sudo apt install gnome-shell-extension-manager
```

### Mapping Keys
Install keyd for keyboard extra sortcuts and personalization
```
git clone https://github.com/rvaiya/keyd
cd keyd
make && sudo make install
sudo systemctl enable keyd && sudo systemctl start keyd
sudo cp leyboard/keyd/default.conf /etc/keyd/
```

# Install sublime text
```
wget -qO - https://download.sublimetext.com/sublimehq-pub.gpg | sudo apt-key add -
echo "deb https://download.sublimetext.com/ apt/stable/" | sudo tee /etc/apt/sources.list.d/sublime-text.list
sudo  apt update
sudo apt install sublime-text
sudo apt-get install sublime-merge
```

### Image and 3d 
Downloading the lastes inkscape release
```
sudo apt install inkscape
```

### install blender
### extract the folder blender-4.2.0-linux-x64 and copy in opt/blender

### Neovim editor
Downloading the lastes neovim release (neovim 0.10 at the current date 26/09/24)
```
curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim.appimage
chmod u+x nvim.appimage
./nvim.appimage --appimage-extract
./squashfs-root/AppRun --version
sudo mkdir -p /opt/nvim
sudo mv squashfs-root/* /opt/nvim
sudo ln -s /opt/nvim/AppRun /usr/bin/nvim
#for clipboard
sudo apt install wl-clipboard   # for wayland
sudo apt install xsel
```

### Conky for desktop monitor
sudo apt install conky-all
sudo apt install lm-sensors


### Backup system configurations
install time-shift
```
sudo apt install time-shift
```
I use this settings:  
Snapshot Type: RSYNC  
Location tab: nvme0n1p4 (same as ubuntu)  
Schedule tab: Weekly, keep: 2  
Users tab:  
dasesu /home/dasesu: Include only hidden files  
root /root: Exclude all  

### Virtualization
Install of virtualbox
```
sudo gdebi virtualbox-7.0_7.0.20-163906~Ubuntu~noble_amd64.deb
# install virtualbox and the extension pack
```
