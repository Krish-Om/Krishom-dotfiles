# export VOLTA_HOME="$HOME/.volta"
# export PATH="$VOLTA_HOME/bin:$PATH"
export PATH="$HOME/conda-bin:$PATH"
alias beekeeper='$HOME/Softwares/Beekeeper-Studio-5.2.6.AppImage'
alias obsidian-start='systemctl --user enable git-sync-obsidian.timer'
alias obsidian-status='systemctl --user status git-sync-obsidian.timer'
alias heroic='flatpak run com.heroicgameslauncher.hgl'
alias nvim='$HOME/Softwares/nvim-linux-x86_64.appimage'
alias zed='$HOME/Softwares/zed-linux-x86_64/zed.app/bin/zed'
alias cursor='$HOME/Softwares/cursor-0.45.14x86_64.AppImage'
alias solidtime='$HOME/Softwares/solidtime-x64/solidtime'
# alias heroic="$HOME/Softwares/Heroic-2.16.1-linux-x86_64.AppImage"
# Add Flatpak exports to XDG data dirs
if [ -d /var/lib/flatpak/exports/share ]; then
  export XDG_DATA_DIRS="/var/lib/flatpak/exports/share:${XDG_DATA_DIRS:-/usr/local/share:/usr/share}"
fi

export EDITOR=nvim
export VISUAL=nvim
alias pico='edit'
alias spico='sedit'
alias nano='edit'
alias snano='sedit'
alias vi='nvim'
alias vim='nvim'
alias py='python3'
alias python='python3'
alias code='code'
# To have colors for ls and all grep commands such as grep, egrep and zgrep
export CLICOLOR=1
export LS_COLORS='no=00:fi=00:di=00;34:ln=01;36:pi=40;33:so=01;35:do=01;35:bd=40;33;01:cd=40;33;01:or=40;31;01:ex=01;32:*.tar=01;31:*.tgz=01;31:*.arj=01;31:*.taz=01;31:*.lzh=01;31:*.zip=01;31:*.z=01;31:*.Z=01;31:*.gz=01;31:*.bz2=01;31:*.deb=01;31:*.rpm=01;31:*.jar=01;31:*.jpg=01;35:*.jpeg=01;35:*.gif=01;35:*.bmp=01;35:*.pbm=01;35:*.pgm=01;35:*.ppm=01;35:*.tga=01;35:*.xbm=01;35:*.xpm=01;35:*.tif=01;35:*.tiff=01;35:*.png=01;35:*.mov=01;35:*.mpg=01;35:*.mpeg=01;35:*.avi=01;35:*.fli=01;35:*.gl=01;35:*.dl=01;35:*.xcf=01;35:*.xwd=01;35:*.ogg=01;35:*.mp3=01;35:*.wav=01;35:*.xml=00;31:'

if command -v rg &>/dev/null; then
  # Alias grep to rg if ripgrep is installed
  alias grep='rg'
else
  # Alias grep to /usr/bin/grep with GREP_OPTIONS if ripgrep is not installed
  alias grep="/usr/bin/grep $GREP_OPTIONS"
fi
unset GREP_OPTIONS

# Alias's to modified commands
alias cp='cp -i'
alias mv='mv -i'
# alias rm='trash -v'
alias mkdir='mkdir -p'
alias ps='ps auxf'
alias ping='ping -c 10'
alias less='less -R'
alias cls='clear'
alias apt-get='sudo apt-get'
alias multitail='multitail --no-repeat -c'
alias freshclam='sudo freshclam'
alias vi='nvim'

# Change directory aliases
alias home='cd ~'
alias cd..='cd ..'
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias .....='cd ../../../..'

# cd into the old directory
alias bd='cd "$OLDPWD"'

# Remove a directory and all files
alias rmd='/bin/rm  --recursive --force --verbose '

# Alias's for multiple directory listing commands
alias la='ls -Alh'               # show hidden files
alias ls='ls --color=always'     # add colors and file type extensions
alias lx='ls -lXBh'              # sort by extension
alias lk='ls -lSrh'              # sort by size
alias lc='ls -ltcrh'             # sort by change time
alias lu='ls -lturh'             # sort by access time
alias lr='ls -lRh'               # recursive ls
alias lt='ls -ltrh'              # sort by date
alias lm='ls -alh |more'         # pipe through 'more'
alias lw='ls -xAh'               # wide listing format
alias ll='ls -Fls'               # long listing format
alias labc='ls -lap'             # alphabetical sort
alias lf="ls -l | egrep -v '^d'" # files only
alias ldir="ls -l | egrep '^d'"  # directories only
alias lla='ls -Al'               # List and Hidden Files
alias las='ls -A'                # Hidden Files
alias lls='ls -l'                # List

# alias chmod commands
alias mx='chmod a+x'
alias 000='chmod -R 000'
alias 644='chmod -R 644'
alias 666='chmod -R 666'
alias 755='chmod -R 755'
alias 777='chmod -R 777'

# Search command line history
alias h="history | grep "

# Search running processes
alias p="ps aux | grep "
alias topcpu="/bin/ps -eo pcpu,pid,user,args | sort -k 1 -r | head -10"

# Search files in the current folder
alias f="find . | grep "

# Count all files (recursively) in the current folder
alias countfiles="for t in files links directories; do echo \`find . -type \${t:0:1} | wc -l\` \$t; done 2> /dev/null"

# To see if a command is aliased, a file, or a built-in command
alias checkcommand="type -t"

# Copy file with a progress bar
cpp() {
  set -e
  strace -q -ewrite cp -- "${1}" "${2}" 2>&1 |
    awk '{
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
    END { print "" }' total_size="$(stat -c '%s' "${1}")" count=0
}

# Copy and go to the directory
cpg() {
  if [ -d "$2" ]; then
    cp "$1" "$2" && cd "$2"
  else
    cp "$1" "$2"
  fi
}
# Move and go to the directory
mvg() {
  if [ -d "$2" ]; then
    mv "$1" "$2" && cd "$2"
  else
    mv "$1" "$2"
  fi
}

# Create and go to the directory
mkdirg() {
  mkdir -p "$1"
  cd "$1"
}

# Goes up a specified number of directories  (i.e. up 4)
up() {
  local d=""
  limit=$1
  for ((i = 1; i <= limit; i++)); do
    d=$d/..
  done
  d=$(echo $d | sed 's/^\///')
  if [ -z "$d" ]; then
    d=..
  fi
  cd $d
}

# Automatically do an ls after each cd, z, or zoxide
cd() {
  if [ -n "$1" ]; then
    builtin cd "$@" && ls
  else
    builtin cd ~ && ls
  fi
}

# Edit the MySQL configuration file
mysqlconfig() {
  if [ -f /etc/my.cnf ]; then
    sedit /etc/my.cnf
  elif [ -f /etc/mysql/my.cnf ]; then
    sedit /etc/mysql/my.cnf
  elif [ -f /usr/local/etc/my.cnf ]; then
    sedit /usr/local/etc/my.cnf
  elif [ -f /usr/bin/mysql/my.cnf ]; then
    sedit /usr/bin/mysql/my.cnf
  elif [ -f ~/my.cnf ]; then
    sedit ~/my.cnf
  elif [ -f ~/.my.cnf ]; then
    sedit ~/.my.cnf
  else
    echo "Error: my.cnf file could not be found."
    echo "Searching for possible locations:"
    sudo updatedb && locate my.cnf
  fi
}

# GitHub Titus Additions

gcom() {
  git add .
  git commit -m "$1"
}
lazyg() {
  git add .
  git commit -m "$1"
  git push
}
lazygb() {
  git add .
  git commit -m "$1"
  git push origin "$2"
}
# Disable the bell
#if [[ $iatest -gt 0 ]]; then bind "set bell-style visible"; fi
# . /usr/share/autojump/autojump.sh

[[ -s /home/krishom/.autojump/etc/profile.d/autojump.sh ]] && source /home/krishom/.autojump/etc/profile.d/autojump.sh

	autoload -U compinit && compinit -u

# Set up fzf key bindings and fuzzy completion

eval "$(starship init zsh)"

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# . "$HOME/.local/bin/env"

# bun completions
[ -s "/home/krishom/.bun/_bun" ] && source "/home/krishom/.bun/_bun"

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"
