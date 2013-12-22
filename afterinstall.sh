#!/bin/bash

createdir(){
  if [[ ! -d "$1" ]]; then mkdir "$1"; fi
}

suretoinstall(){
  read -p "Are you sure to install $1? " -n 1 -r
  echo    # (optional) move to a new line
  if [[ $REPLY =~ ^[Yy]$ ]]
  then
      sudo apt-get install $1 -y
  fi
}

createdir ~/bin
createdir ~/programming/node 
createdir ~/programming/scripts/ 

sudo apt-get update
sudo apt-get upgrade -y
sudo apt-get dist-upgrade 

# install chrome with dependencies
read -p "Are you sure to install google-chrome? " -n 1 -r
echo 
if [[ $REPLY =~ ^[Yy]$ ]]
then
cd /tmp
  wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb -O chrome.deb
  sudo dpkg -i chrome.deb
  sudo apt-get -f install -y
  rm -rf chrome.deb
fi

# install necessary
sudo apt-get install vim git unity-tweak-tool zsh indicator-multiload vlc rar openjdk-7-jre ubuntu-restricted-extras tmux compizconfig-settings-manager compiz-plugins-extra indicator-cpufreq libappindicator1 python-pip htop deluge colormake -y

suretoinstall texlive 

# vundle
read -p "Are you sure to install vundle to manage your vim plugins? " -n 1 -r
echo 
if [[ $REPLY =~ ^[Yy]$ ]]
then
cd /tmp
  git clone https://github.com/gmarik/vundle.git ~/.vim/bundle/vundle
  cp ./.vimrc ~
  cp ./.tmux.conf ~
  cp ./.tmuxline.conf ~
  vim +BundleInstall +qall!
fi

# Lokaltog/powerline
# uninstall with : pip uninstall powerline
# pip install --user git+git://github.com/Lokaltog/powerline

# network speed indicator
cd ~/programming/scripts 
wget http://webupd8.googlecode.com/files/sysmon_0.2.tar.gz && tar -xvf sysmon_0.2.tar.gz

# git config
git config --global color.ui auto

# oh-my-zsh
cd /tmp
wget --no-check-certificate https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh -O - | sh
cd ~
sudo chsh -s /bin/zsh
sed -i 's/robbyrussell/af-magic/' ~/.zshrc
sed -i 's/plugins=(git)/plugins=(git virtualenv node npm colorize)/' ~/.zshrc
sed -i "s#\(export\ PATH=\"\)\(.*\)#\1/home/$(whoami)/bin:~/\.local/bin:\2#" ~/.zshrc
# "
# sed -i -r 's#(export\ PATH=")(.*)#\1~/bin:~/.local/bin:\2#' ~/.zshrc

# install clementine
sudo add-apt-repository ppa:me-davidsansome/clementine -y
# install tlp power management
sudo add-apt-repository ppa:linrunner/tlp -y
# install new nvidia drivers from xorg-edgers
sudo add-apt-repository ppa:xorg-edgers/ppa -y

sudo apt-get install clementine -y
sudo apt-get install nvidia-331 -y
sudo apt-get install tlp tlp-rdw smartmontools ethtool -y
sudo tlp start

# purge unnecessary packages
sudo apt-get purge unity-scope-gdrive unity-scope-musicstores unity-scope-gmusicbrowser unity-lens-friends unity-scope-audacious unity-scope-guayadeque unity-scope-firefoxbookmarks unity-scope-virtualbox unity-scope-yelp unity-lens-video unity-lens-photos unity-lens-music unity-scope-chromiumbookmarks rhythmbox account-plugin-facebook account-plugin-aim account-plugin-windows-live account-plugin-flickr account-plugin-yahoo account-plugin-jabber account-plugin-salut brasero brasero-cdrkit brasero-common gnome-mahjongg unity-lens-photos unit-lens-music -y

####################################################################
# fix ubuntu privacy fixubuntu.com
# Figure out the version of Ubuntu that you're running
V=`/usr/bin/lsb_release -rs`
 
# The privacy problems started with 12.10, so earlier versions should do nothing
if [ $V \< 12.10 ]; then
  echo ""
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
      "['more_suggestions-amazon.scope', 'more_suggestions-u1ms.scope',
      'more_suggestions-populartracks.scope', 'music-musicstore.scope',
      'more_suggestions-ebay.scope', 'more_suggestions-ubuntushop.scope',
      'more_suggestions-skimlinks.scope']"
  fi;
 
  # Block connections to Ubuntu's ad server, just in case
  if ! grep -q productsearch.ubuntu.com /etc/hosts; then
    echo -e "\n127.0.0.1 productsearch.ubuntu.com" | sudo tee -a /etc/hosts >/dev/null
  fi
 
  echo ""
  echo "All done. Enjoy your privacy."
fi
################################################################

# disable overlay scrollbars
gsettings set com.canonical.desktop.interface scrollbar-mode normal

# disable guest login 
echo allow-guest=false | sudo tee -a /etc/lightdm/lightdm.conf.d/50-unity-greeter.conf

# disable crash reports
sudo sed -i 's/enabled=1/enabled=0/' /etc/default/apport 

# DOES NOT WORK ? 
#sudo xhost +SI:localuser:lightdm
#sudo su lightdm -s /bin/bash
#gsettings set com.canonical.unity-greeter draw-grid false

sudo apt-get update
sudo apt-get upgrade -y
sudo apt-get dist-upgrade -y

echo ""
echo ""
echo "Configuration complete :). Enjoy!"

