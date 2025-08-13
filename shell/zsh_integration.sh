# Path Navigator Function for Zsh
# DO NOT EDIT - This file is automatically installed by setup.sh

nav() {
    local chosen_path
    chosen_path=$(python3 ~/bin/path_navigator.py "$@")
    
    if [ $? -eq 0 ] && [ -n "$chosen_path" ]; then
        cd "$chosen_path"
        echo "📍 Changed to: $(pwd)"
    fi
}

# Aliases
alias n='nav'
alias nedit='python3 ~/bin/path_navigator.py --edit'
alias nlist='python3 ~/bin/path_navigator.py --list'
alias ndebug='python3 ~/bin/path_navigator.py --debug'

# Quick jump aliases
alias n1='nav 1'
alias n2='nav 2'
alias n3='nav 3'
alias n4='nav 4'
alias n5='nav 5'
alias n6='nav 6'
alias n7='nav 7'
alias n8='nav 8'
alias n9='nav 9'
alias n10='nav 10'