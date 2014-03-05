#!/bin/bash

# Colors
ESC_SEQ="\x1b["
COL_RESET=$ESC_SEQ"39;49;00m"
COL_RED=$ESC_SEQ"31;01m"
COL_GREEN=$ESC_SEQ"32;01m"
COL_YELLOW=$ESC_SEQ"33;01m"
COL_BLUE=$ESC_SEQ"34;01m"
COL_MAGENTA=$ESC_SEQ"35;01m"
COL_CYAN=$ESC_SEQ"36;01m"

current_dir=`pwd`
toinstall=""
topurge=""

createdir(){
  if [[ ! -d "$1" ]]; then mkdir -p "$1"; fi
}

suretopurge(){
  echo -e "$COL_YELLOW " && read -p "Are you sure to purge $1 ('y' to purge)? " -n 1 -r ; echo -e "$COL_RESET"
  if [[ $REPLY =~ ^[Yy]$ ]]
  then
      $topurge="$topurge $1"
      # sudo apt-get purge $1 -y
  fi
}

suretoinstall(){
  echo -e "$col_yellow " && read -p "are you sure to install $1 ('y' to install)? " -n 1 -r ; echo -e "$col_reset"
  if [[ $reply =~ ^[yy]$ ]]
  then
      $toinstall="$toinstall $1"
      # sudo apt-get install $1 -y
  fi
}

createdir ~/bin/
createdir ~/programming/node/
createdir ~/programming/scripts/ 
createdir ~/.fonts/

suretopurge empathy
suretopurge shotwell-common
suretopurge eog
suretopurge thunderbird
suretoinstall samba
# gwenview instead of eog and shotwell for managing photos
suretoinstall gwenview
suretoinstall gimp

echo -e "$col_yellow " && read -p "Do you want to install Java Development Kit ('y' to install)? " -n 1 -r ; echo -e "$col_reset"
if [[ $reply =~ ^[Yy]$ ]]
then
  $toinstall="$toinstall oracle-jdk7-installer"
else
  $toinstall="$toinstall oracle-java7-installer"
fi

# purge unnecessary packages
sudo apt-get purge unity-scope-gdrive unity-scope-musicstores unity-scope-gmusicbrowser unity-lens-friends unity-scope-audacious unity-scope-guayadeque unity-scope-firefoxbookmarks unity-scope-virtualbox unity-scope-yelp unity-lens-video unity-lens-photos unity-lens-music unity-scope-chromiumbookmarks rhythmbox account-plugin-facebook account-plugin-aim account-plugin-windows-live account-plugin-flickr account-plugin-yahoo account-plugin-jabber account-plugin-salut brasero brasero-cdrkit brasero-common gnome-mahjongg unity-lens-photos unity-scope-openclipart unity-scope-musique unity-scope-colourlovers gnome-orca unity-scope-zotero unity-scope-tomboy unity-scope-texdoc transmission-common transmission-gtk unity-scope-video-remote totem account-plugin-twitter friends-twitter landscape-client-ui-install $topurge -y

# install clementine
sudo add-apt-repository ppa:me-davidsansome/clementine -y
# install tlp power management
sudo add-apt-repository ppa:linrunner/tlp -y
# install new nvidia drivers from xorg-edgers
# sudo add-apt-repository ppa:xorg-edgers/ppa -y
# add  webupd8 PPA for java installation
sudo add-apt-repository ppa:webupd8team/java -y
# vlc stable ppa
sudo add-apt-repository ppa:djcj/vlc-stable -y
# gimp updates yet not bleeding edge
sudo add-apt-repository ppa:otto-kesselgulasch/gimp -y

sudo apt-get update

sudo apt-get install clementine -y
# sudo apt-get install nvidia-331 -y
sudo apt-get install tlp tlp-rdw smartmontools ethtool -y
sudo tlp start

# install necessary
sudo apt-get install vim git unity-tweak-tool zsh indicator-multiload vlc rar ubuntu-restricted-extras tmux compizconfig-settings-manager compiz-plugins-extra indicator-cpufreq libappindicator1 python-pip htop deluge colormake xsel synaptic $toinstall -y
sudo apt-get upgrade -y

# install chrome with dependencies
echo -e "$COL_YELLOW" && read -p "Are you sure to install google-chrome? " -n 1 -r ; echo -e "$COL_RESET"
if [[ $REPLY =~ ^[Yy]$ ]]
then
  cd /tmp
  wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb -O chrome.deb
  sudo dpkg -i chrome.deb
  sudo apt-get -f install -y
  rm -rf chrome.deb
fi

# vundle
echo -e "$COL_YELLOW" && read -p "Are you sure to install vundle to manage your vim plugins? " -n 1 -r ; echo -e "$COL_RESET"
if [[ $REPLY =~ ^[Yy]$ ]]
then
  git clone https://github.com/gmarik/vundle.git ~/.vim/bundle/vundle
  cp $current_dir/.vimrc ~
  cp $current_dir/.tmux.conf ~
  cp $current_dir/.tmuxline.conf ~
  sed -i 's/.*solarized.*/"\ &/g' ~/.vimrc
  vim +BundleInstall +qall!
  sed -i 's/"\ \(.*solarized.*\)/\1/g' ~/.vimrc
  ln -s ~/.vim/bundle/xmledit/ftplugin/xml.vim ~/.vim/bundle/xmledit/ftplugin/html.vim
fi

# Lokaltog/powerline
# uninstall with : pip uninstall powerline
# pip install --user git+git://github.com/Lokaltog/powerline

# network speed indicator
cd ~/programming/scripts 
wget http://webupd8.googlecode.com/files/sysmon_0.2.tar.gz && tar -xvf sysmon_0.2.tar.gz

# copy indicator-multiload config
sudo cp $current_dir/preferences.ui /usr/share/indicator-multiload/preferences.ui

# git config
git config --global color.ui auto

# oh-my-zsh and zsh config
cd /tmp
wget --no-check-certificate https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh -O - | sh
cd ~
chsh -s /bin/zsh
sed -i 's@robbyrussell@af-magic@' ~/.zshrc
sed -i 's@plugins=(git)@plugins=(git virtualenv node npm copyfile copydir)@' ~/.zshrc
sed -i "s@\(export\ PATH=\"\)\(.*\)@\1/home/$(whoami)/bin:~/\.local/bin:\2@" ~/.zshrc
sed -i -r "s@PROMPT=(.*virtualenv_)@RPROMPT=\1@" ~/.oh-my-zsh/themes/af-magic.zsh-theme
echo "alias pbcopy='xsel --clipboard --input'" >> ~/.zshrc
echo "alias pbpaste='xsel --clipboard --output'" >> ~/.zshrc
# echo "alias ll='ls -lh" >> ~/.zshrc
echo "alias lt='ls -lhtr" >> ~/.zshrc
echo "alias la='ls -lhA" >> ~/.zshrc

# Powerline fonts for gnome terminal
cd ~/.fonts/ && wget https://github.com/Lokaltog/powerline-fonts/archive/master.zip && unzip master.zip 
mv powerline-fonts-master/* . && rm -rf master.zip powerline-fonts-master
fc-cache -vf ~/.fonts
gconftool-2 --set /apps/gnome-terminal/profiles/Default/font --type string "Ubuntu Mono derivative Powerline 11"
gconftool-2 --set /apps/gnome-terminal/profiles/Default/use_system_font --type bool "false"

echo -e "$COL_YELLOW" && read -p "Do you want to set tmux as your default terminal command? (y to confirm) " -n 1 -r ; echo -e "$COL_RESET"
if [[ $REPLY =~ ^[Yy]$ ]]
then
  gconftool-2 --set /apps/gnome-terminal/profiles/Default/use_custom_command --type bool true
  gconftool-2 --set /apps/gnome-terminal/profiles/Default/custom_command --type string "tmux -2"
fi

####################################################################
# fix ubuntu privacy fixubuntu.com
# Figure out the version of Ubuntu that you're running
V=`/usr/bin/lsb_release -rs`
 
# The privacy problems started with 12.10, so earlier versions should do nothing
if [ $V \< 12.10 ]; then
  echo "\nGood news! Your version of Ubuntu doesn't invade your privacy.\n"
else
  # Turn off "Remote Search", so search terms in Dash don't get sent to the internet
  gsettings set com.canonical.Unity.Lenses remote-content-search none
 
  # If you're using earlier than 13.10, uninstall unity-lens-shopping
  if [ $V \< 13.10 ]; then
    sudo apt-get remove -y unity-lens-shopping
 
  # If you're using a later version, disable remote scopes
  else
    gsettings set com.canonical.Unity.Lenses disabled-scopes \
      "['more_suggestions-amazon.scope', 'more_suggestions-u1ms.scope', 'more_suggestions-populartracks.scope', 'music-musicstore.scope', 'more_suggestions-ebay.scope', 'more_suggestions-ubuntushop.scope', 'more_suggestions-skimlinks.scope']"
  fi;
 
  # Block connections to Ubuntu's ad server, just in case
  if ! grep -q productsearch.ubuntu.com /etc/hosts; then
    echo -e "\n127.0.0.1 productsearch.ubuntu.com" | sudo tee -a /etc/hosts >/dev/null
  fi
  echo -e "$COL_YELLOW All done. Enjoy your privacy. $COL_RESET"
fi
################################################################

# remove amazon from dash
sudo rm -rf /usr/share/applications/ubuntu-amazon-default.desktop

# disable overlay scrollbars
gsettings set com.canonical.desktop.interface scrollbar-mode normal

# disable guest login 
echo allow-guest=false | sudo tee -a /etc/lightdm/lightdm.conf.d/50-unity-greeter.conf

# disable crash reports
sudo sed -i 's/enabled=1/enabled=0/' /etc/default/apport 

# check updates each 2 weeks
dconf write /com/ubuntu/update-notifier/regular-auto-launch-interval 14

# DOES NOT WORK ? 
#sudo xhost +SI:localuser:lightdm
#sudo su lightdm -s /bin/bash
#gsettings set com.canonical.unity-greeter draw-grid false

echo -e "\n $COL_YELLOW Configuration complete :). Enjoy! $COL_RESET"
