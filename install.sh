#! /usr/bin/env bash

APT_COMMAND="sudo apt -y install "

add_package_to_command() {
    package_name=$1

    RED='\033[0;31m'
    GREEN='\033[0;32m'
    NC='\033[0m' # No Color
    if ! $package_name --version &> /dev/null
    then
        echo -e "adding${GREEN} $package_name to package list${NC}"
        APT_COMMAND+=" $package_name "
    else
        echo -e "$package_name ${RED}is already installed${NC}"
    fi
}

install_brave_browser() {
    sudo apt install apt-transport-https curl

    sudo curl -fsSLo /usr/share/keyrings/brave-browser-archive-keyring.gpg https://brave-browser-apt-release.s3.brave.com/brave-browser-archive-keyring.gpg

    echo "deb [signed-by=/usr/share/keyrings/brave-browser-archive-keyring.gpg arch=amd64] https://brave-browser-apt-release.s3.brave.com/ stable main"|sudo tee /etc/apt/sources.list.d/brave-browser-release.list

    sudo apt update

    sudo apt install brave-browser
}

# emacs stuff
install_emacs() {
    sudo add-apt-repository ppa:kelleyk/emacs
    sudo apt update
    sudo apt install emacs27
}

install_doom_emacs() {
    git clone --depth 1 https://github.com/hlissner/doom-emacs ~/.emacs.d
    ~/.emacs.d/bin/doom install
}
# emacs stuff

# zsh stuff
install_zsh() {
    sudo apt-get install zsh
    APT_COMMAND+=" zsh "
}

install_oh_my_zsh() {
    sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
}

install_powerlevel10k() {
    git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k

    sed -i 's/ZSH_THEME=\"robbyrussell\"/ZSH_THEME=\"powerlevel10k\/powerlevel10k\"/' ~/.zshrc
}
# zsh stuff

install_obs() {
    sudo add-apt-repository ppa:obsproject/obs-studio
    sudo apt update
    sudo apt -y install ffmpeg
    sudo apt -y install obs-studio
    sudo apt -y install v4l2loopback-dkms
}

APT_COMMAND+=" git "
APT_COMMAND+=" python "
APT_COMMAND+=" python3 "
APT_COMMAND+=" ripgrep "
APT_COMMAND+=" timeshift "
APT_COMMAND+=" kitty "
APT_COMMAND+=" ffmpeg "
APT_COMMAND+=" audacity "
APT_COMMAND+=" vim "
APT_COMMAND+=" yakuake "
APT_COMMAND+=" krita "
APT_COMMAND+=" qbittorrent "
APT_COMMAND+=" htop "
APT_COMMAND+=" neovim "
APT_COMMAND+=" qdirstat "
APT_COMMAND+=" tmux "
APT_COMMAND+=" gimp "
APT_COMMAND+=" filelight "
APT_COMMAND+=" libreoffice "
APT_COMMAND+=" mpv "
APT_COMMAND+=" kdeconnect "
APT_COMMAND+=" simplescreenrecorder "
APT_COMMAND+=" darktable "
APT_COMMAND+=" handbrake "
APT_COMMAND+=" kdenlive "
APT_COMMAND+=" shotcut "
APT_COMMAND+=" mediainfo "
APT_COMMAND+=" mediainfo-gui "
APT_COMMAND+=" speedcrunch "
APT_COMMAND+=" xdotool "
APT_COMMAND+=" zenity "
APT_COMMAND+=" vlc "
APT_COMMAND+=" okular "


if ! brave-browser --version &> /dev/null
then
    install_brave_browser;
fi

if ! zsh --version &> /dev/null
then
    install_zsh;
    install_oh_my_zsh;
    install_powerlevel10k;
fi

if ! emacs --version &> /dev/null
then
    install_emacs;
    install_doom_emacs;
fi


install_obs;

echo ""
echo "about to install the following packages: "
echo ""
echo $APT_COMMAND
echo ""
$APT_COMMAND

echo ""
echo "finished"
echo ""
