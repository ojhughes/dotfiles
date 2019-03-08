source /usr/local/share/antigen/antigen.zsh
source ~/.aliases
source ~/.zsh_completion
antigen bundle vi-mode
antigen bundle z
antigen bundle zsh-users/zsh-history-substring-search ./zsh-history-substring-search.zsh
antigen bundle git      # Enables the zsh completion from git
antigen bundle git-extras# Enables the zsh completion from git
antigen bundle history     # maven completion
antigen bundle mvn     # maven completion
antigen bundle copydir # Mac clipborad copy current directory
antigen bundle copyfile    # Mac clipborad copy file
antigen bundle docker      # Docker autocompletion
antigen bundle brew
antigen bundle brew-cask
#antigen bundle python      # aliase only?
antigen bundle z           # z command
antigen bundle command-not-found
antigen bundle common-aliases # https://github.com/robbyrussell/oh-my-zsh/blob/master/plugins/common-aliases/common-aliases.plugin.zsh

#antigen bundle autojump # Enables autojump if installed with homebrew
antigen bundle mafredri/zsh-async
antigen bundle sindresorhus/pure
antigen bundle zsh-users/zsh-syntax-highlighting
antigen apply

bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down
bindkey -a '^[[3~' delete-char

export GOPATH=$HOME/workspace/go
export PATH=$PATH:/usr/local/go/bin:$GOPATH/bin
export PATH=/usr/local/opt/coreutils/libexec/gnubin:/usr/local/Cellar/rsync/3.1.3_1/bin:$PATH
export WORKON_HOME=$HOME/.virtualenvs
export PROJECT_HOME=$HOME/workspace
export LC_ALL=en_GB.UTF-8
source /usr/local/bin/virtualenvwrapper.sh

rgbpw() {
   pcf --target $1 cf-info | sed -n '1p' | cut -d':' -f2 | awk '{$1=$1};1'
}
create-test-org() {
   cf create-org ollie && cf target -o ollie && cf create-space test && cf target -o ollie
}
target() {
    pcf --target $1 target
}
boshenv() {
    eval "$(om -t "https://pcf.${1}.springapps.io" -k -u pivotalcf -p pivotalcf bosh-env)"
}
setopt APPEND_HISTORY          # history appends to existing file
setopt HIST_FIND_NO_DUPS       # history search finds once only
setopt HIST_IGNORE_ALL_DUPS    # remove all earlier duplicate lines
setopt HIST_REDUCE_BLANKS      # trim multiple insgnificant blanks in history
setopt HIST_NO_STORE           # remove the history (fc -l) command from the history when invoked

HISTFILE=$HOME/.zsh_history    # history file location
HISTSIZE=1000000               # number of history lines kept internally
SAVEHIST=1000000
setopt    sharehistory      #Share history across terminals
setopt    incappendhistory  #Immediately append to the history file, not just when a term is killed
eval "$(direnv hook zsh)"
source "$HOME/.sdkman/bin/sdkman-init.sh"
