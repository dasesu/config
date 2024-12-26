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
gsettings set org.gnome.desktop.interface text-scaling-factor 1.1500
```

### Dark theme
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

### Small icon size
```
gsettings set org.gnome.shell.extensions.ding icon-size 'small'
```

### The panel
Attach the panel at bottom with size of 40
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
configuration original state with a modified state as shown below:
```
gsettings list-recursively > file1
# do some change using the GUI
gsettings list-recursively > file2
diff file1 file2
```

### Shortcuts
I define my favorites shortcuts manually, for example:
<alt>e -- open firefox  
<alt>w -- minimize or hide window  
<ctrl><alt>f -- open the home folder  

### Install tree for visualize files
```
sudo apt install tree
```
### Install fzf
```
sudo apt install fzf
```

And then add the next command to `~/.bashrc`
```
# for go to a directory
alias asd='cd "$( find . -type d | fzf --height=60% --layout=reverse  --border --margin=1 --padding=1 )"'

# for open the file with nvim
alias dsa='nvim "$( find . -type f | fzf --height=60% --layout=reverse  --border --margin=1 --padding=1 )"'
```

### File and Directory permissions
To restore the original permission on copied files or directories, be careful with the executables.
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

### Install multimedia
```
sudo apt install ubuntu-restricted-extras
sudo apt install mplayer 

# sudo snap install vlc #(optional)
sudo gdebi vdhcoapp-linux-x86_64.deb # for the video downloader helper plugin
# Download the Video Downloader
```

### Git
```
sudo apt install ssh
sudo apt install git
git config --global user.name "username"
git config --global user.email "somemail@gmail.com"
ssh-keygen -t rsa -C "somemail@gmail.com"
```

### Gdbi for .deb files installation
```
sudo apt install gdebi
```

### Vpn
```
# sudo gdebi expressvpn_3.76.0.4-1_amd64.deb #(optional)
```

### Chrome
```
sudo gdebi google-chrome-stable_current_amd64.deb
```

### Installing Curl
```
sudo apt install curl
```

### Gnome-shell extension manager 
```
sudo apt install gnome-shell-extension-manager
```

### Mapping Keys
Install keyd for keyboard extra shortcuts and keys personalization
```
git clone https://github.com/rvaiya/keyd
cd keyd
make && sudo make install
sudo systemctl enable keyd && sudo systemctl start keyd
sudo cp leyboard/keyd/default.conf /etc/keyd/
```

### Install sublime text
```
wget -qO - https://download.sublimetext.com/sublimehq-pub.gpg | sudo apt-key add -
echo "deb https://download.sublimetext.com/ apt/stable/" | sudo tee /etc/apt/sources.list.d/sublime-text.list
sudo  apt update
sudo apt install sublime-text
sudo apt-get install sublime-merge
```

### Image and 3d 
Downloading the last inkscape release
```
sudo apt install inkscape
```

### Install blender
Extract the blender-4.2.0-linux-x64.zip and copy the content to opt/blender

### Neovim editor
Downloading the last neovim release (neovim 0.10 at the current date 26/09/24)
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
Install virtualbox
```
sudo gdebi virtualbox-7.0_7.0.20-163906~Ubuntu~noble_amd64.deb
# install virtualbox and the extension pack
```

### Install glow for a better markdown experience
```
sudo snap install glow
```

### Sticky notes
```
# check this steps again
sudo apt install flatpak
sudo apt install gnome-software-plugin-flatpak
flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo
flatpak install flathub com.vixalien.sticky
flatpak run com.vixalien.sticky
```

### Install octave
```
sudo add-apt-repository ppa:ubuntuhandbook1/octave
sudo apt update
sudo apt install octave
```

### Install gimp
```
sudo apt install gimp
```

### Install ratbagd for config logitech mouse
```
sudo apt install cmake libudev-dev libevdev-dev libsystemd-dev libglib2.0-dev libjson-glib-dev libunistring-dev check valgrind swig

git clone https://github.com/libratbag/libratbag.git
meson builddir --prefix=/usr/
ninja -C builddir
sudo ninja -C builddir install
sudo ratbagd
```

### Install Piper
```
git clone https://github.com/libratbag/piper.git
meson builddir --prefix=/usr/
sudo apt install python3-lxml
sudo apt install python3-cairo
sudo apt install python3-gi
sudo apt install python3-evdev
meson builddir --prefix=/usr/
ninja -C builddir
sudo ninja -C builddir install
piper
```

### Install Docker using the apt repository
```
sudo apt-get remove docker docker-engine docker.io containerd runc

# Add Docker's official GPG key:
sudo apt-get update
sudo apt-get install ca-certificates curl
sudo install -m 0755 -d /etc/apt/keyrings
sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
sudo chmod a+r /etc/apt/keyrings/docker.asc

# Add the repository to Apt sources:
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu \
  $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt-get update

# Install the Docker packages.
sudo apt-get install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

# Verify that the installation is successful by running the hello-world image
sudo docker run hello-world
```
