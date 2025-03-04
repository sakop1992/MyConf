export PATH="/opt/homebrew/bin:$PATH"

# ----------------------------------------
# GENERAL SETTINGS
# ----------------------------------------

# History settings
HISTSIZE=50000               # Number of commands to remember in memory
SAVEHIST=90000               # Number of commands to save to the history file
HISTFILE=~/.zsh_history      # File where history is saved
setopt APPEND_HISTORY         # Append to history instead of overwriting
setopt SHARE_HISTORY          # Share history between sessions
setopt INC_APPEND_HISTORY     # Add commands to history immediately
setopt HIST_IGNORE_DUPS       # Ignore duplicate entries
setopt HIST_REDUCE_BLANKS     # Remove extra spaces in commands

# Case-insensitive globbing
setopt NO_CASE_GLOB

# Enable auto-correction for mistyped commands
setopt CORRECT

# Improve tab completion
autoload -Uz compinit && compinit

# Disable "beep" on errors
setopt NO_BEEP

# Enable extended globbing (e.g., `ls **/*.txt`)
setopt EXTENDED_GLOB

# ----------------------------------------
# PROMPT SETTINGS
# ----------------------------------------

# Define colors for the prompt
autoload -U colors && colors

# Function to get the current Git branch
git_branch() {
    git rev-parse --abbrev-ref HEAD 2>/dev/null || echo ''
}

# Define the prompt with the current Git branch if in a Git repository
setopt PROMPT_SUBST
export PROMPT='%F{magenta}%n %F{cyan}%~%f %F{yellow}[$(git_branch)]%f$ '

# Show exit status of the last command if it failed
TRAPZERR() {
    echo "Error: Command exited with status $?"
}

# Add hostname to the terminal title
precmd() {
    print -Pn "\e]0;%n@%m: %~\a"
}

# ----------------------------------------
# ALIASES
# ----------------------------------------

# Colorized `ls` and shortcuts
alias ls='ls -G'
alias ll='ls -lh'
alias lll='ls -lha'
alias l='ls -CF'

# Grep with colors
alias grep='grep --color=auto'

# Screen
alias sl='screen -ls'
function sa { screen -d $1; screen -r $1;}
alias sc='screen -S'
alias sd='screen -d'
# kill detached session
function sk { screen -X -S $1 quit; }

# Directory navigation shortcuts
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias ~='cd ~'

# Update and upgrade system
alias update='sudo apt-get update && sudo apt-get upgrade -y'

# Easier editing
alias e='nano'
alias vim='nvim'

# Reload .zshrc
alias reload='source ~/.zshrc'

# Clipboard shortcuts (if `xclip` is installed)
alias pbcopy='xclip -selection clipboard'
alias pbpaste='xclip -selection clipboard -o'

# Git shortcuts
alias gs='git branch && git status'
alias gaNew='git add'
alias gaOld='git add . && git clang-format && git add .'
alias ga='git add .'
alias gc='git commit -m'
alias gp='git push'
alias glNew='git log --oneline --graph --decorate --all'
alias gl='git log --format="%h %C(bold red)%ad %Creset%Cred(%ar) %Creset%C(bold green)%an%C(bold yellow)%d %C(reset)%s" --date=short'
alias gco='git checkout'
alias gcb='git checkout -b'
alias gd='git diff'
alias gundo='git reset --soft HEAD~1'
alias gmn='git commit --amend --no-edit'

# gtags
alias gtAll='gtags'
alias gt='GTAGSCONF=~/.globalrc_no_tests gtags'

alias Kopzon='cd ~/MyConf'

# Fireblocks
alias core='cd ~/git/core'
alias core1='cd ~/git_1/core'
alias core2='cd ~/git_2/core'
alias core3='cd ~/git_3/core'

# ----------------------------------------
# PATH & ENVIRONMENT
# ----------------------------------------

# Add custom scripts directory to PATH
export PATH="$HOME/bin:$PATH"

# Prefer UTF-8
export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8

# Set default editor
export EDITOR=nano

# Use modern pager
export PAGER=less
export LESS='-R'

# ----------------------------------------
# PLUGINS & COMPLETIONS
# ----------------------------------------

# Load zsh-autosuggestions (if installed)
if [ -f /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh ]; then
    source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
    ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=8'
fi

# Load zsh-syntax-highlighting (if installed)
if [ -f /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh ]; then
    source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
fi

# ----------------------------------------
# FUNCTIONS
# ----------------------------------------

# Search for a pattern recursively in files
fsearch() {
    grep -rnw '.' -e "$1"
}

# Extract various archive types
extract() {
    if [ -f "$1" ]; then
        case "$1" in
            *.tar.bz2) tar xjf "$1" ;;
            *.tar.gz) tar xzf "$1" ;;
            *.bz2) bunzip2 "$1" ;;
            *.rar) unrar x "$1" ;;
            *.gz) gunzip "$1" ;;
            *.tar) tar xf "$1" ;;
            *.tbz2) tar xjf "$1" ;;
            *.tgz) tar xzf "$1" ;;
            *.zip) unzip "$1" ;;
            *.Z) uncompress "$1" ;;
            *.7z) 7z x "$1" ;;
            *) echo "Cannot extract '$1'" ;;
        esac
    else
        echo "'$1' is not a valid file"
    fi
}

# Time long-running commands
long_running_cmd() {
    SECONDS=0
    "$@"
    duration=$SECONDS
    echo "Command completed in $((duration / 60)) minutes and $((duration % 60)) seconds."
}
alias timecmd='long_running_cmd'

# $1 - pattern
# $2 - src
# $3 - dst
function copy_files_by_pattern { if [ "$#" -ne 3 ]; then echo "args: pattern src dst"; else mkdir -p $3; find $2 -maxdepth 1 -type f | grep -i $1 | xargs -i cp {} $3; fi; }

# parameters:
    # $1 - blob (file) hash
    # $2 - grep pattern for remote branch names to search in
    # $3 - number of commits back you want to check
function find_commit_by_blob(){
found=0;
for brch in $(git branch -r | grep -i $2); do
    echo "CHECKING BRANCH ${brch}";
    for cur in $(git log ${brch} -$3 --format='%H-%T'); do
        echo "Checking ${cur}";
        git ls-tree -r $(echo ${cur}| awk -F- '{print $2}') | grep $1 && echo 'FOUND IT!' && found=1 && break;
    done;
    if [ $found -eq 1 ]; then 
        break;
    fi;
done
}

#################################################################
# Fireblocks
#################################################################

alias docker='/usr/local/bin/docker'
alias npm='/opt/homebrew/bin/npm'
alias fb='/opt/homebrew/bin/fb'
alias fbh='fb rentblocks'
alias fbr='fb rentblocks:create'
alias fbp='fb rentblocks:proxy'
alias fbs='fb rentblocks:ssh'

# ----------------------------------------
# END OF .zshrc
# ----------------------------------------

