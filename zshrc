source /usr/local/Cellar/antigen/2.2.3/share/antigen/antigen.zsh
antigen bundle z
antigen bundle zsh-users/zsh-history-substring-search ./zsh-history-substring-search.zsh
antigen bundle git      # Enables the zsh completion from git
antigen bundle git-extras# Enables the zsh completion from git
#antigen bundle brew     # adds completion for the brew command
antigen bundle dircycle # This is a small zle trick that lets you cycle your directory stack left or right using Ctrl+Shift+Left/Right
#antigen bundle gnu-utils
antigen bundle history
antigen bundle mvn     # maven completion
antigen bundle copydir # Mac clipborad copy current directory
antigen bundle copyfile    # Mac clipborad copy file
antigen bundle dirpersist  # Make the dirstack more persistant for .zlogout
antigen bundle docker      # Docker autocompletion
antigen bundle sudo        # Defined shortcut keys: [Esc] [Esc]
antigen bundle brew
antigen bundle brew-cask
#antigen bundle python      # aliase only?
antigen bundle z           # z command
antigen bundle command-not-found
antigen bundle common-aliases # https://github.com/robbyrussell/oh-my-zsh/blob/master/plugins/common-aliases/common-aliases.plugin.zsh

antigen bundle sharat87/autoenv
antigen bundle zsh-users/zsh-completions src
antigen bundle zsh-users/zsh-autosuggestions
antigen bundle autojump # Enables autojump if installed with homebrew
antigen bundle vi-mode
antigen bundle sindresorhus/pure

zmodload zsh/terminfo
bindkey "$terminfo[kcuu1]" history-substring-search-up
bindkey "$terminfo[kcud1]" history-substring-search-down
bindkey -a '^[[3~' delete-key

function boshenv() {

    function setenv() {
        if (which om | grep "not found"); then
            echo "'om' must be installed before using this script; see https://github.com/pivotal-cf/om#installation"
            return 1
        fi

        if (which bosh2 | grep "not found"); then
            echo "bosh v2 CLI must be installed before using this script; see https://bosh.io/docs/cli-v2.html#install"
            return 1
        fi

        if (which jq | grep "not found"); then
            echo "'jq' must be installed before using this script; see https://stedolan.github.io/jq/"
            return 1
        fi

        export OM_TARGET="$1"
        export OM_ADMIN="$2"
        export OM_PASSWORD="$3"

        # Unset BOSH_* env vars
        while read var; do unset $var; done < <(env | grep BOSH | cut -d'=' -f1)

        # Test om access
        TEST_COMMAND=$(om -t $OM_TARGET -k -u $OM_ADMIN curl -s -path /api/v0/deployed/products)
        if [ $? -ne 0 ]; then
            echo "Error: $TEST_COMMAND"
            return 1
        fi

        # Get director IP
        BOSH_PRODUCT_GUID=$(om -t $OM_TARGET -k -u $OM_ADMIN curl -s -path /api/v0/deployed/products/ | jq -r -c '.[] | select(.type | contains("p-bosh")) | .guid')
        export BOSH_ENVIRONMENT=$(om -t $OM_TARGET -k -u $OM_ADMIN curl -s -path /api/v0/deployed/products/$BOSH_PRODUCT_GUID/static_ips | jq -r '.[].ips[]')

        # Get director root cert
        export BOSH_CA_CERT="$(om -t $OM_TARGET -k -u $OM_ADMIN curl -s -path /api/v0/certificate_authorities | jq -r '.certificate_authorities[].cert_pem')"

        # Get director credentials
        export BOSH_USERNAME=$(om -t $OM_TARGET -k -u $OM_ADMIN curl -s -path /api/v0/deployed/director/credentials/director_credentials | jq -r '.credential.value.identity')
        export BOSH_PASSWORD=$(om -t $OM_TARGET -k -u $OM_ADMIN curl -s -path /api/v0/deployed/director/credentials/director_credentials | jq -r '.credential.value.password')

        # Log-in to get UAA token
        echo -e "$BOSH_USERNAME\n$BOSH_PASSWORD\n" | bosh2 log-in
        bosh2 env
    }

    if [ "$#" -eq 0 ]; then
        echo "Current environment is $BOSH_ENVIRONMENT"
    elif [ "$#" -eq 3 ]; then
        setenv "$1" "$2" "$3"
    else
        echo "Usage: $0 OM_TARGET OM_ADMIN_USERNAME OM_PASSWORD"
    fi
}
export GOPATH=$HOME/workspace/go
export JAVA_HOME=$(/usr/libexec/java_home)
export PATH=$PATH:/usr/local/go/bin:$GOPATH/bin

[[ -f /usr/local/lib/node_modules/generator-jhipster/node_modules/tabtab/.completions/jhipster.zsh ]] && . /usr/local/lib/node_modules/generator-jhipster/node_modules/tabtab/.completions/jhipster.zsh
export WORKON_HOME=$HOME/.virtualenvs
export PROJECT_HOME=$HOME/workspace
source /usr/local/bin/virtualenvwrapper.sh

function rgbpw() {
   pcf --target $1 cf-info | sed -n '1p' | cut -d':' -f2 | awk '{$1=$1};1'
}
function create-test-org() {
   cf create-org ollie && cf target -o ollie && cf create-space test && cf target -o ollie
}
target() {
    pcf --target $1 target
}

