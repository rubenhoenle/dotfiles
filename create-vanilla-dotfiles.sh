vanilla_dotfiles_dir="vanilla-dotfiles"

mkdir -p $vanilla_dotfiles_dir
mkdir -p $vanilla_dotfiles_dir/waybar
mkdir -p $vanilla_dotfiles_dir/sway
mkdir -p $vanilla_dotfiles_dir/swaylock
mkdir -p $vanilla_dotfiles_dir/alacritty
mkdir -p $vanilla_dotfiles_dir/wofi
mkdir -p $vanilla_dotfiles_dir/git
mkdir -p $vanilla_dotfiles_dir/mako
mkdir -p $vanilla_dotfiles_dir/nvim/lua/ruben

################################################################################

# WAYBAR

cp ~/.config/waybar/config $vanilla_dotfiles_dir/waybar/config
chmod 644 $vanilla_dotfiles_dir/waybar/config

cp ~/.config/waybar/style.css $vanilla_dotfiles_dir/waybar/style.css
chmod 644 $vanilla_dotfiles_dir/waybar/style.css

################################################################################

# SWAY

cp ~/.config/sway/config $vanilla_dotfiles_dir/sway/config
chmod 644 $vanilla_dotfiles_dir/sway/config

################################################################################

# SWAYLOCK

cp ~/.config/swaylock/config $vanilla_dotfiles_dir/swaylock/config
chmod 644 $vanilla_dotfiles_dir/swaylock/config

################################################################################

# ALACRITTY

cp ~/.config/alacritty/alacritty.toml $vanilla_dotfiles_dir/alacritty/alacritty.toml
chmod 644 $vanilla_dotfiles_dir/alacritty/alacritty.toml

################################################################################

# WOFI

cp ~/.config/wofi/style.css $vanilla_dotfiles_dir/wofi/style.css
chmod 644 $vanilla_dotfiles_dir/wofi/style.css

################################################################################

# GIT

cp ~/.config/git/config $vanilla_dotfiles_dir/git/config
chmod 644 $vanilla_dotfiles_dir/git/config

################################################################################

# MAKO

cp ~/.config/mako/config $vanilla_dotfiles_dir/mako/config
chmod 644 $vanilla_dotfiles_dir/mako/config

################################################################################

# NVIM

cp ~/.config/nvim/init.lua $vanilla_dotfiles_dir/nvim/init.lua
chmod 644 $vanilla_dotfiles_dir/nvim/init.lua

cp ~/.config/nvim/lua/ruben/*.lua $vanilla_dotfiles_dir/nvim/lua/ruben
chmod 644 $vanilla_dotfiles_dir/nvim/lua/ruben/*.lua

################################################################################

sed -i 's/\/nix\/store\/[a-z0-9.\-]\+\/bin\///g' $vanilla_dotfiles_dir/waybar/config
sed -i 's/\/nix\/store\/[a-z0-9.\-]\+\/bin\///g' $vanilla_dotfiles_dir/sway/config
sed -i 's/\/nix\/store\/[a-z0-9.\-]\+\/bin\///g' $vanilla_dotfiles_dir/swaylock/config

