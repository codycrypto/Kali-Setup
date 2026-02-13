#!/bin/zsh

############## Step 1 Install Rustup ##############

curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh

. "$HOME/.cargo/env"

rustup override set stable
rustup update stable

########### Step 2 Install Alacritty ###########

sudo apt install cmake g++ pkg-config libfontconfig1-dev libxcb-xfixes0-dev libxkbcommon-dev python3
cargo build --release

git clone https://github.com/alacritty/alacritty.git
cd alacritty

cargo build --release

### Desktop Entry
sudo cp target/release/alacritty /usr/local/bin # or anywhere else in $PATH
sudo cp extra/logo/alacritty-term.svg /usr/share/pixmaps/Alacritty.svg
sudo desktop-file-install extra/linux/Alacritty.desktop
sudo update-desktop-database

####### Shell Completions ############
mkdir -p ${ZDOTDIR:-~}/.zsh_functions
echo 'fpath+=${ZDOTDIR:-~}/.zsh_functions' >> ${ZDOTDIR:-~}/.zshrc
cp extra/completions/_alacritty ${ZDOTDIR:-~}/.zsh_functions/_alacritty

########### Step 3 - Install Homebrew ###########

/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# - Run these commands in your terminal to add Homebrew to your PATH:
    echo >> /home/parallels/.zshrc
    echo 'eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv zsh)"' >> /home/parallels/.zshrc
    eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv zsh)"
# - Install Homebrew's dependencies if you have sudo access:
    sudo apt-get install build-essential

########### Step 4 - Install Fonts ##############

cd /tmp
wget https://github.com/ryanoasis/nerd-fonts/releases/latest/download/CascadiaMono.zip
unzip CascadiaMono.zip -d CascadiaFont
sudo mkdir -p /usr/share/fonts/truetype/CascadiaMono
sudo cp CascadiaFont/*.ttf /usr/share/fonts/truetype/CascadiaMono
rm -rf CascadiaMono.zip CascadiaFont

wget https://github.com/ryanoasis/nerd-fonts/releases/latest/download/JetBrainsMono.zip
unzip JetBrainsMono.zip -d JetBrainsMono
sudo mkdir -p /usr/share/fonts/truetype/JetBrainsMono
sudo cp JetBrainsMono/*.ttf /usr/share/fonts/truetype/JetBrainsMono
rm -rf JetBrainsMono.zip JetBrainsMono

wget https://github.com/ryanoasis/nerd-fonts/releases/latest/download/Meslo.zip
unzip Meslo.zip -d Meslo
sudo mkdir -p /usr/share/fonts/truetype/Meslo
sudo cp Meslo/*.ttf /usr/share/fonts/truetype/Meslo
rm -rf Meslo.zip Meslo

fc-cache

######### Step 5 - Install tools #################

sudo apt install {

fd-find
asciinema
neovim
luarocks
tree-sitter-cli

}

curl -LsSf https://astral.sh/uv/install.sh | sh

######### Step 6 - Configure NeoVim/Lazyvim #################

mkdir -p "$HOME/.config/nvim"
git clone https://github.com/LazyVim/starter ~/.config/nvim
# Remove the .git folder, so you can add it to your own repo later
rm -rf ~/.config/nvim/.git
cp configs/nvim/aura.lua $HOME/.config/nvim/lua/plugins


######### Step 7 - Install ohmyposh ###############

