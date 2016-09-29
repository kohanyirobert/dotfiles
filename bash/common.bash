_parse_git_branch() {
  git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/'
}
_get_password() {
  security 2>&1 >/dev/null find-internet-password -gs $1 | sed 's,^password: "\(.*\)"$,\1,'
}
_smb_mount() {
  mount -t smbfs //rkohanyi:$(_get_password mp-net-nas01)@mp-net-nas01/$1 $HOME/mnt/$1
}
_ssh_mount() {
  sshfs -o reconnect,volname=$1 $1:/ $HOME/mnt/$1
}
_pong() {
  ping $1 | perl -nle 'print scalar(localtime), " ", $_'
}
_vim_server_foreground() {
  servername=$1
  pane_pid=$(vim --servername $servername --remote-expr 'system("ps -p " . getpid() . " -o ppid=")')
  tmux_ids=$(tmux list-panes -a -F '#{pane_pid} #{session_id} #{window_id} #{pane_id}')
  read session_id window_id pane_id <<< $(awk -v pane_pid=$pane_pid '{
    if ($1 == pane_pid) {
      print $2, $3, $4
      exit 0
    }
  }' <<< "$tmux_ids")
  tmux switch-client -t $session_id
  tmux select-window -t $window_id
  tmux select-pane -t $pane_id
}
_vim_server() {
  servername=$1
  shift
  vim --serverlist | grep -qi "^$servername$"
  if [ $? -eq 0 ]
  then
    if [ $# -eq 0 ]
    then
      vim --servername $servername
    else
      vim --servername $servername --remote-silent "$@"
    fi
  else
    vim --servername $servername "$@"
  fi
  vim --serverlist | grep -qi "^$servername$"
  if [ $? -eq 0 ]
  then
    _vim_server_foreground $servername
  fi
}
_gvim_server() {
  servername=$1
  shift
  mvim --serverlist | grep -qi "^$servername$"
  if [ $? -eq 0 ]
  then
    if [ $# -eq 0 ]
    then
      reattach-to-user-namespace mvim --servername $servername --remote-send ':call foreground()<cr>'
    else
      reattach-to-user-namespace mvim --servername $servername --remote-silent "$@"
    fi
  else
    reattach-to-user-namespace mvim --servername $servername "$@"
  fi
}

shopt -s histappend

PS1=
if [[ $EUID -eq 0 ]]
then
  PS1='\u@\h \w]\n\$ '
else
  PS1='\u@\h \w\[\033[32m\]$(_parse_git_branch)\[\033[00m\]\n\$ '
fi
export PS1
export LESS=-RFX
export CLICOLOR=1
export LSCOLORS=ExFxBxDxCxegedabagacad
export NLS_CHARACTERSET=AL32UTF8
export NLS_LANG=.AL32UTF8
export HH_CONFIG=hicolor,keywords
export HH_PROMPT='$ '
export HISTCONTROL=ignorespace:ignoredups:erasedups
export HISTSIZE=1000000
export HISTFILESIZE=$HISTSIZE
export HISTTIMEFORMAT='%F %T '
export HISTIGNORE='fg:hh'
export PROMPT_COMMAND="history -a; ${PROMPT_COMMAND}"

export MANPATH="$(brew --prefix coreutils)/libexec/gnuman:$MANPATH"
export KDIFF3_HOME="/Applications/kdiff3.app/Contents"
export IDEA_HOME="/Applications/IntelliJ IDEA 14 CE.app/Contents"
export INSTANTCLIENT_HOME="$HOME/oracle/instantclient_11_2"
export DYLD_LIBRARY_PATH="$INSTANTCLIENT_HOME"
export PDFTK_HOME="/opt/pdflabs/pdftk"
export LUNCHY_HOME="$(dirname `gem which lunchy`)/../extras"

export GRADLE_HOME="/usr/local/opt/gradle/libexec"

export JAVA_6_HOME=$(/usr/libexec/java_home -v1.6)
export JAVA_7_HOME=$(/usr/libexec/java_home -v1.7)
export JAVA_8_HOME=$(/usr/libexec/java_home -v1.8)

export JAVA_HOME=$JAVA_8_HOME

PATH="$(brew --prefix coreutils)/libexec/gnubin:$PATH"
PATH="/usr/local/sbin:/usr/local/bin:$PATH"
PATH="$HOME/git/pfctl-helper:$HOME/bin:$PATH"
PATH="$KDIFF3_HOME/MacOS:$PATH"
PATH="$IDEA_HOME/MacOS:$PATH"
PATH="$INSTANTCLIENT_HOME:$PATH"
PATH="$GRADLE_HOME/bin:$PATH"
export PATH

alias u='history -n'
alias pong='_pong'
alias v='_vim_server VIM'
alias vs='_vim_server'
alias g='_gvim_server GVIM'
alias gs='_gvim_server'

alias ls='ls --color=always'
alias grep='grep --color=always'
alias cl='clear'
alias cls='clear'
alias rm="echo use 'thrash' or 'del' instead or use rm via its fullpath '/bin/rm'"
alias del="rmtrash"
alias thrash="rmtrash"
alias pa='ps aux | grep -v grep | grep'
alias bd='. bd -si'
alias java6='export JAVA_HOME=$JAVA_6_HOME'
alias java7='export JAVA_HOME=$JAVA_7_HOME'
alias java8='export JAVA_HOME=$JAVA_8_HOME'
alias docker-rm='docker ps -aq | xargs docker rm'
alias docker-kill='docker ps -aq | xargs docker kill'

if [ -f $(brew --prefix)/etc/bash_completion ]
then
  source $(brew --prefix)/etc/bash_completion
fi

if [ -f $LUNCHY_HOME/lunchy-completion.bash ]
then
  source $LUNCHY_HOME/lunchy-completion.bash
fi

if [[ $- =~ .*i.* ]]
then
  bind '"\C-r": "\C-a\C-khh\C-j"'
fi

complete -C aws_completer aws
