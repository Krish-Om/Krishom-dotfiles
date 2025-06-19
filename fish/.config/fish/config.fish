# Fish shell configuration converted from .zshrc
# Date: June 4, 2025

set -g fish_greeting
# PATH exports
# set -gx PATH "$HOME/conda-bin" $PATH

# Application aliases
alias zen "$HOME/Softwares/zen-*.AppImage"
# alias beekeeper "$HOME/Softwares/Beekeeper-Studio-*.AppImage"
alias obsidian "$HOME/Softwares/Obsidian-1.8.10.AppImage --disable-gpu"
alias obsidian-start "systemctl --user enable git-sync-obsidian.timer"
alias obsidian-status "systemctl --user status git-sync-obsidian.timer"
alias heroic "flatpak run com.heroicgameslauncher.hgl"
alias nvim "$HOME/Softwares/nvim-linux-x86_64.appimage"
alias zed "$HOME/Softwares/zed-linux-x86_64/zed.app/bin/zed"
alias cursor "$HOME/Softwares/cursor-*x86_64.AppImage"
alias solidtime "$HOME/Softwares/solidtime-x64/solidtime"
alias launchconda "$HOME/Softwares/conda.sh"
# Add Flatpak exports to XDG data dirs
if test -d /var/lib/flatpak/exports/share
    set -gx XDG_DATA_DIRS "/var/lib/flatpak/exports/share:$XDG_DATA_DIRS"
end

# Editor settings
set -gx EDITOR nvim
set -gx VISUAL nvim

# Text editor aliases
alias pico edit
alias spico sedit
alias nano edit
alias snano sedit
alias vi nvim
alias vim nvim

# Python aliases
alias py python3
alias python python3

# Code alias
alias code code
# Colors for ls and grep commands
set -gx CLICOLOR 1
set -gx LS_COLORS 'no=00:fi=00:di=00;34:ln=01;36:pi=40;33:so=01;35:do=01;35:bd=40;33;01:cd=40;33;01:or=40;31;01:ex=01;32:*.tar=01;31:*.tgz=01;31:*.arj=01;31:*.taz=01;31:*.lzh=01;31:*.zip=01;31:*.z=01;31:*.Z=01;31:*.gz=01;31:*.bz2=01;31:*.deb=01;31:*.rpm=01;*.jar=01;31:*.jpg=01;35:*.jpeg=01;35:*.gif=01;35:*.bmp=01;35:*.pbm=01;35:*.pgm=01;35:*.ppm=01;35:*.tga=01;35:*.xbm=01;35:*.xpm=01;35:*.tif=01;35:*.tiff=01;35:*.png=01;35:*.mov=01;35:*.mpg=01;35:*.mpeg=01;35:*.avi=01;35:*.fli=01;35:*.gl=01;35:*.dl=01;35:*.xcf=01;35:*.xwd=01;35:*.ogg=01;35:*.mp3=01;35:*.wav=01;35:*.xml=00;31:'

# Conditional grep alias
if command -v rg >/dev/null 2>&1
    alias grep rg
else
    alias grep /usr/bin/grep
end

# Modified command aliases
alias cp "cp -i"
alias mv "mv -i"
alias mkdir "mkdir -p"
alias ps "ps auxf"
alias ping "ping -c 10"
alias less "less -R"
alias cls clear
alias apt-get "sudo apt-get"
alias multitail "multitail --no-repeat -c"
alias freshclam "sudo freshclam"

# Change directory aliases
alias home "cd ~"
alias cd.. "cd .."
alias .. "cd .."
alias ... "cd ../.."
alias .... "cd ../../.."
alias ..... "cd ../../../.."

# cd into the old directory
alias bd "cd \$OLDPWD"

# Remove a directory and all files
alias rmd "/bin/rm --recursive --force --verbose"

# Directory listing aliases
alias la "ls -Alh" # show hidden files
alias ls "ls --color=always" # add colors and file type extensions
alias lx "ls -lXBh" # sort by extension
alias lk "ls -lSrh" # sort by size
alias lc "ls -ltcrh" # sort by change time
alias lu "ls -lturh" # sort by access time
alias lr "ls -lRh" # recursive ls
alias lt "ls -ltrh" # sort by date
alias lm "ls -alh | more" # pipe through 'more'
alias lw "ls -xAh" # wide listing format
alias ll "ls -Fls" # long listing format
alias labc "ls -lap" # alphabetical sort
alias lf "ls -l | egrep -v '^d'" # files only
alias ldir "ls -l | egrep '^d'" # directories only
alias lla "ls -Al" # List and Hidden Files
alias las "ls -A" # Hidden Files
alias lls "ls -l" # List

# chmod aliases
alias mx "chmod a+x"
alias 000 "chmod -R 000"
alias 644 "chmod -R 644"
alias 666 "chmod -R 666"
alias 755 "chmod -R 755"
alias 777 "chmod -R 777"

# Search aliases
alias h "history | grep"
alias p "ps aux | grep"
alias topcpu "/bin/ps -eo pcpu,pid,user,args | sort -k 1 -r | head -10"
alias f "find . | grep"
alias checkcommand "type -t"

# Fish functions

# Count files function (Fish version)
function countfiles
    for t in files links directories
        set type_flag (string sub -s 1 -l 1 $t)
        set count (find . -type $type_flag 2>/dev/null | wc -l)
        echo "$count $t"
    end
end

# Copy file with progress bar
function cpp
    set -l src $argv[1]
    set -l dst $argv[2]

    if not test -f "$src"
        echo "Source file not found: $src"
        return 1
    end

    set -l total_size (stat -c '%s' "$src")
    strace -q -ewrite cp -- "$src" "$dst" 2>&1 | awk -v total_size=$total_size '
    {
        count += $NF
        if (count % 10 == 0) {
            percent = count / total_size * 100
            printf "%3d%% [", percent
            for (i=0;i<=percent;i++)
                printf "="
            printf ">"
            for (i=percent;i<100;i++)
                printf " "
            printf "]\r"
        }
    }
    END { print "" }'
end

# Copy and go to directory
function cpg
    if test -d $argv[2]
        cp $argv[1] $argv[2]; and cd $argv[2]
    else
        cp $argv[1] $argv[2]
    end
end

# Move and go to directory
function mvg
    if test -d $argv[2]
        mv $argv[1] $argv[2]; and cd $argv[2]
    else
        mv $argv[1] $argv[2]
    end
end

# Create and go to directory
function mkdirg
    mkdir -p $argv[1]
    cd $argv[1]
end

# Go up specified number of directories
function up
    set -l limit $argv[1]
    set -l d ""
    for i in (seq 1 $limit)
        set d "$d/.."
    end
    set d (string replace -r '^/' '' $d)
    if test -z "$d"
        set d ".."
    end
    cd $d
end

# Auto ls after cd
function cd
    if test (count $argv) -gt 0
        builtin cd $argv; and ls
    else
        builtin cd ~; and ls
    end
end

# Edit MySQL configuration
function mysqlconfig
    set -l config_files /etc/my.cnf /etc/mysql/my.cnf /usr/local/etc/my.cnf /usr/bin/mysql/my.cnf ~/my.cnf ~/.my.cnf

    for config in $config_files
        if test -f $config
            sedit $config
            return
        end
    end

    echo "Error: my.cnf file could not be found."
    echo "Searching for possible locations:"
    sudo updatedb; and locate my.cnf
end

# Git functions
function gcom
    git add .
    git commit -m $argv[1]
end

function lazyg
    git add .
    git commit -m $argv[1]
    git push
end

function lazygb
    git add .
    git commit -m $argv[1]
    git push origin $argv[2]
end
#conda 

function conda-init
    set -gx PATH /home/krishom/anaconda3/bin $PATH
    eval (/home/krishom/anaconda3/bin/conda shell.fish hook)
end
# funcsave conda-init
# Autojump setup
if test -s /home/krishom/.autojump/etc/profile.d/autojump.fish
    source /home/krishom/.autojump/etc/profile.d/autojump.fish 2>/dev/null
end

# Starship prompt
if command -v starship >/dev/null 2>&1
    starship init fish | source
end

# FZF setup
if test -f ~/.config/fish/functions/fzf_key_bindings.fish
    source ~/.config/fish/functions/fzf_key_bindings.fish 2>/dev/null
else if test -f ~/.fzf/shell/key-bindings.fish
    source ~/.fzf/shell/key-bindings.fish 2>/dev/null
end

# Bun setup (PATH only, skip completions if problematic)
set -gx BUN_INSTALL "$HOME/.bun"
set -gx PATH "$BUN_INSTALL/bin" $PATH

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
# if test -f /home/krishom/anaconda3/bin/conda
#     eval /home/krishom/anaconda3/bin/conda "shell.fish" hook $argv | source
# else
#     if test -f "/home/krishom/anaconda3/etc/fish/conf.d/conda.fish"
#         . "/home/krishom/anaconda3/etc/fish/conf.d/conda.fish"
#     else
#         set -x PATH /home/krishom/anaconda3/bin $PATH
#     end
# end
# <<< conda initialize <<<
