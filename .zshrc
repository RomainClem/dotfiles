export ZSH="$HOME/.oh-my-zsh"

#Aliases
alias wi="cd ~/WorkSpace/Repos/WebInterface"

#Theme
ZSH_THEME=""

#Plugins
plugins=(git zsh-autosuggestions zsh-syntax-highlighting)
source $ZSH/oh-my-zsh.sh

#Exports
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
# Automatically set Windows host IP for WSL
export WINDOWS_HOST_IP=$(grep -m 1 nameserver /etc/resolv.conf | awk '{print $2}')

# export APIProxy__Target="https://${WINDOWS_HOST_IP}:7120"
export SSL_CERT_DIR=$HOME/.aspnet/dev-certs/trust:/usr/lib/ssl/certs

#Star Ship
eval "$(starship init zsh)"

# bun                    
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"