HISTSIZE=10000
SAVEHIST=10000
HISTFILE=~/.zsh_history

autoload -Uz compinit && compinit

alias la='ls -la --color=auto'
alias vim='nvim'
alias ls='ls --color=auto'
alias grep='grep --color=auto'
source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
export PATH="$HOME/.local/bin:$PATH"
PROMPT='%F{2}%n@%m%f:%F{4}%~%f$ '

bwu(){
	export BW_SESSION=$(bw unlock --raw)
	echo -n "$BW_SESSION" | keyctl padd user bw_session @u
}

bwadd() {
    local name=$1
    local uri=$2
    local user=$3
    local pass=${4:-$(bw generate -ulns --length 20)}
    
    echo "Password: $pass"
    echo -n "$pass" | wl-copy
    
    bw get template item | python3 -c "
import json, sys
t = json.load(sys.stdin)
t['name'] = '$name'
t['type'] = 1
t['login'] = {'username': '$user', 'password': '$pass', 'uris': [{'match': None, 'uri': '$uri'}]}
print(json.dumps(t))" | bw encode | bw create item
    
    bw sync
}
