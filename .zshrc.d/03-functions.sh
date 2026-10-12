# 03-functions.sh: Shell Functions

function y() {
    local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
    command yazi "$@" --cwd-file="$tmp"
    IFS= read -r -d '' cwd <"$tmp"
    [ "$cwd" != "$PWD" ] && [ -d "$cwd" ] && builtin cd -- "$cwd"
    rm -f -- "$tmp"
}

fcd() {
    local file
    # file=$(fzf --height 40%)
    file=$(fzf -m --preview='bat -n --color=always {}')
    if [ -n "$file" ]; then
        cd "$(dirname "$file")"
    fi
}

sdku() {
    if [ -z "$1" ]; then
        echo "No version specified. Usage: sdku <VERSION>"
        return 1
    fi
    local version=$(sdk list java | rg installed | rg " $1" | awk '{print $NF}' | head -n 1)
    if [ -n "$version" ]; then
        sdk use java "$version"
    else
        echo "No installed java version found matching: $1"
    fi
}

mkjsroot() {
    cat <<EOF >jsconfig.json
{
  "compilerOptions": {
    "allowJs": true,
    "checkJs": false,
    "noEmit": true
  },
  "exclude": ["node_modules"]
}
EOF
    echo "Created jsconfig.json"
}

mkroot() {
    echo "{}" >package.json
    echo "Create empty package.json"
}

bwp() {
    local session
    session=$(security find-generic-password -a "$USER" -s "BW_SESSION" -w 2>/dev/null)

    if [[ -z "$session" ]]; then
        echo "Vault is locked. Unlocking..."
        session=$(bw unlock --raw)
        security add-generic-password -a "$USER" -s "BW_SESSION" -w "$session" -U
    fi

    local item_id
    item_id=$(bw list items --session "$session" |
        jq -r '.[] | "\(.name) ::: \(.id)"' |
        fzf --prompt="Bitwarden > " --delimiter=" ::: " --with-nth=1 |
        awk -F " ::: " '{print $2}')

    if [[ -n "$item_id" ]]; then
        bw get password "$item_id" --session "$session" | pbcopy
        echo "Password copied to clipboard."
    fi
}
