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
# script dir
DIR="$( cd "$( dirname "$0"  )" && pwd )"
toinstall=""
topurge=""

createdir(){
  if [[ ! -d "$1" ]]; then mkdir -p "$1"; fi
}

suretopurge(){
  echo -e "$COL_YELLOW " && read -p "Are you sure to purge $1 ('y' to purge)? " -n 1 -r ; echo -e "$COL_RESET"
  if [[ $REPLY =~ ^[Yy]$ ]]
  then
    topurge="$topurge $1"
    echo "\"$topurge\""
    # sudo apt-get purge $1 -y
  fi
}

suretoinstall(){
  echo -e "$COL_YELLOW " && read -p "Are you sure to install $1 ('y' to install)? " -n 1 -r ; echo -e "$col_reset"
  if [[ $reply =~ ^[Yy]$ ]]
  then
    toinstall="$toinstall $1"
    # sudo apt-get install $1 -y
  fi
}

createdir ~/bin/
createdir ~/programming/{c,hackerrank,node,scripts}
createdir ~/.fonts/

# Fixes Skype theme on 64 bit systems
if [[ `uname -m` =~ .*64.* ]] ; then
  toinstall="$toinstall gtk2-engines-murrine:i386"
fi

# purge unnecessary packages
sudo apt-get purge unity-scope-gdrive unity-scope-musicstores unity-scope-gmusicbrowser unity-scope-audacious unity-scope-firefoxbookmarks unity-scope-virtualbox unity-scope-yelp unity-scope-chromiumbookmarks rhythmbox account-plugin-facebook account-plugin-aim account-plugin-windows-live account-plugin-flickr account-plugin-yahoo account-plugin-jabber account-plugin-salut brasero brasero-cdrkit brasero-common gnome-mahjongg unity-scope-openclipart unity-scope-musique unity-scope-colourlovers gnome-orca unity-scope-zotero unity-scope-tomboy unity-scope-texdoc transmission-common transmission-gtk unity-scope-video-remote totem account-plugin-twitter landscape-client-ui-install gnome-mines gnome-sudoku gnome-mahjongg empathy gimp clementine $topurge -y

# latest stable git release
sudo add-apt-repository ppa:git-core/ppa -y
# deluge team ppa
sudo add-apt-repository ppa:deluge-team/ppa -y

sudo apt-get update

# install necessary
sudo apt-get install software-properties-common vim-nox git zsh indicator-multiload vlc ubuntu-restricted-extras tmux compizconfig-settings-manager compiz-plugins-extra libappindicator1 python-pip htop deluge colormake xsel synaptic openssh-client openssh-server shutter curl $toinstall -V -y
sudo apt-get purge `dpkg -l | grep unity-lens | grep -v unity-lens-files | grep -v unity-lens-applications | awk '{print $2}'` -y
sudo apt-get upgrade -y
sudo apt-get dist-upgrade -y

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


####################################################################
############################ VUNDLE
echo -e "$COL_YELLOW" && read -p "Are you sure to install vundle to manage your vim plugins? " -n 1 -r ; echo -e "$COL_RESET"
if [[ $REPLY =~ ^[Yy]$ ]]
then
  echo -e "\n $COL_YELLOW Installing Vundle.vim ...\n $COL_RESET"
  git clone --depth 1 https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
  cp $DIR/.vimrc ~
  cp $DIR/.tmux.conf ~
  cp $DIR/.tmuxline.conf ~
  sed -i 's/colorscheme solarized/"\ &/g' ~/.vimrc
  vim +PluginInstall +qall!
  sed -i 's/"\ \(colorscheme solarized\)/\1/g' ~/.vimrc
  vim +PluginInstall +qall!
  ln -s ~/.vim/bundle/xmledit/ftplugin/xml.vim ~/.vim/bundle/xmledit/ftplugin/html.vim
fi
############################ END OF VUNDLE
####################################################################


# network speed indicator
cd ~/programming/scripts
wget http://webupd8.googlecode.com/files/sysmon_0.2.tar.gz && tar -xvf sysmon_0.2.tar.gz

# copy indicator-multiload config
sudo cp $DIR/preferences.ui /usr/share/indicator-multiload/preferences.ui


####################################################################
#################       BEGIN OF OH-MY-ZSH
echo -e "\n $COL_YELLOW Installing and configuring oh-my-zsh...\n $COL_RESET"
cd /tmp && wget --no-check-certificate https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh -O - | sh
cd ~
chsh -s /bin/zsh
sed -i 's@robbyrussell@af-magic@' ~/.zshrc
sed -i 's@plugins=(git)@plugins=(git git-extras virtualenv node npm copyfile copydir sudo encode64 mvn nyan pip golang)@' ~/.zshrc
sed -i "s@\(export\ PATH=\"\)\(.*\)@\1/home/$(whoami)/bin:~/\.local/bin:\2@" ~/.zshrc
# oh-my-zsh fix for afmagic theme
sed -i -r "s@PROMPT=(.*virtualenv_)@RPROMPT=\1@" ~/.oh-my-zsh/themes/af-magic.zsh-theme
echo "alias pbcopy='xsel --clipboard --input'" >> ~/.zshrc
echo "alias pbpaste='xsel --clipboard --output'" >> ~/.zshrc
echo "alias tmux='tmux -2'" >> ~/.zshrc
echo "alias ll='ls -lhF'" >> ~/.zshrc
echo "alias lt='ls -lhtr'" >> ~/.zshrc
echo "alias la='ls -lhA'" >> ~/.zshrc
# lines and lines_sort methods
cat "$DIR/zshrc_methods" >> ~/.zshrc
# zsh-syntax-highlighting
( rm -rf ~/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting && cd ~/.oh-my-zsh/custom/plugins && \
git clone --depth 1 git://github.com/zsh-users/zsh-syntax-highlighting.git 2> /dev/null && \
if ! grep -q zsh-syntax-highlighting ~/.zshrc; then sed -i -r 's#^(plugins=.*)\)#\1 zsh-syntax-highlighting)#' ~/.zshrc; fi && \
sed -i '/ZSH_HIGHLIGHT_.*/d' ~/.zshrc

cat << EOF >> ~/.zshrc

ZSH_HIGHLIGHT_HIGHLIGHTERS=( main brackets pattern)
ZSH_HIGHLIGHT_PATTERNS+=('rm -rf *' 'fg=white,bold,bg=red')
ZSH_HIGHLIGHT_STYLES[bracket-level-1]='fg=blue,bold'
ZSH_HIGHLIGHT_STYLES[bracket-level-2]='fg=red,bold'
ZSH_HIGHLIGHT_STYLES[bracket-level-3]='fg=yellow,bold'
ZSH_HIGHLIGHT_STYLES[bracket-level-4]='fg=magenta,bold'
EOF
)

# add shell completion after -t= parameters
echo "setopt magic_equal_subst" >> ~/.zshrc
################         END OF OH-MY-ZSH
####################################################################


####################################################################
echo -e "\n $COL_YELLOW Installing tmux plugins...\n $COL_RESET"
git clone --depth 1 https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm/
git clone --depth 1 https://github.com/tmux-plugins/tmux-copycat ~/.tmux/plugins/tmux-copycat/
git clone --depth 1 https://github.com/tmux-plugins/tmux-yank ~/.tmux/plugins/tmux-yank/
git clone --depth 1 https://github.com/tmux-plugins/tmux-resurrect ~/.tmux/plugins/tmux-resurrect/
git clone --depth 1 https://github.com/seebi/tmux-colors-solarized ~/.tmux/plugins/tmux-colors-solarized/
tmux source ~/.tmux.conf
####################################################################


####################################################################
############### Powerline fonts for gnome terminal
( cd ~/.fonts/ && wget https://github.com/Lokaltog/powerline-fonts/archive/master.zip && unzip master.zip && \
  mv powerline-fonts-master/* . && rm -rf master.zip powerline-fonts-master && fc-cache -vf ~/.fonts
gconftool-2 --set /apps/gnome-terminal/profiles/Default/font --type string "Ubuntu Mono derivative Powerline 11"
gconftool-2 --set /apps/gnome-terminal/profiles/Default/use_system_font --type bool "false" )

echo -e "$COL_YELLOW" && read -p "Do you want to set tmux as your default terminal command? (y to confirm) " -n 1 -r ; echo -e "$COL_RESET"
if [[ $REPLY =~ ^[Yy]$ ]]
then
  gconftool-2 --set /apps/gnome-terminal/profiles/Default/use_custom_command --type bool true
  gconftool-2 --set /apps/gnome-terminal/profiles/Default/custom_command --type string "tmux -2"
fi
####################################################################


####################################################################
############## fix ubuntu privacy fixubuntu.com
############## Figure out the version of Ubuntu that you're running
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
sudo rm -rf /usr/share/applications/ubuntu-amazon-default.desktop 2>/dev/null

# disable overlay scrollbars
gsettings set com.canonical.desktop.interface scrollbar-mode normal

# disable guest login
[[ -s " /etc/lightdm/lightdm.conf.d/50-unity-greeter.conf" ]] && \
  echo allow-guest=false | sudo tee -a /etc/lightdm/lightdm.conf.d/50-unity-greeter.conf

# disable crash reports
[[ -s "/etc/default/apport" ]] && sudo sed -i 's/enabled=1/enabled=0/' /etc/default/apport

# check updates each 2 weeks
dconf write /com/ubuntu/update-notifier/regular-auto-launch-interval 14

# DOES NOT WORK ?
#sudo xhost +SI:localuser:lightdm
#sudo su lightdm -s /bin/bash
#gsettings set com.canonical.unity-greeter draw-grid false



################################################################
echo -e "\n $COL_YELLOW Installing gvm and go...\n $COL_RESET"
sudo apt-get install bison -y
bash < <(curl -s -S -L https://raw.githubusercontent.com/moovweb/gvm/master/binscripts/gvm-installer) && \
  source /home/monkey/.gvm/scripts/gvm && \
  gvm install go1.4 && gvm use go1.4 && export GOROOT_BOOTSTRAP=$GOROOT && \
  gvm install go1.6.2 && gvm use go1.6.2 && gvm uninstall go1.4
cat << EOF >> ~/.zshrc
[[ -s "/home/monkey/.gvm/scripts/gvm" ]] && source "/home/monkey/.gvm/scripts/gvm"
gvm use go1.6.2 >/dev/null
EOF
################################################################

################################################################
echo -e "\n $COL_YELLOW Installing silver_searcher - ag...\n $COL_RESET"
sudo apt-get install automake pkg-config libpcre3-dev zlib1g-dev liblzma-dev -y
cd /tmp && git clone --depth 1 https://github.com/ggreer/the_silver_searcher.git ag && cd ag && \
  ./build.sh >/dev/null 2>&1
################################################################

cd $current_dir
echo -e "\n $COL_YELLOW Configuration complete :). Enjoy!\n $COL_RESET"
