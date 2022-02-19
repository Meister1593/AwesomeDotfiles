# .bashrc

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

PS1='[\u@\h \W]\$ '

#export PATH="$PATH:~/.fnm"
#export PATH="$PATH:~/.local/bin"

export GOBIN=~/go/bin
export CARGOBIN=~/.cargo/bin
export FNM=~/.fnm
export LOCALBIN=~/.local/bin
export PATH="$FNM:$GOBIN:$CARGOBIN:$LOCALBIN:$PATH"

if [[ $(ps --no-header --pid=$PPID --format=cmd) != "fish" && -z ${BASH_EXECUTION_STRING} ]]
then
	exec fish
fi

# BEGIN_KITTY_SHELL_INTEGRATION
if test -n "$KITTY_INSTALLATION_DIR" -a -e "$KITTY_INSTALLATION_DIR/shell-integration/bash/kitty.bash"; then source "$KITTY_INSTALLATION_DIR/shell-integration/bash/kitty.bash"; fi
# END_KITTY_SHELL_INTEGRATION
