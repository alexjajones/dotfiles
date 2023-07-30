selected=$(ls ~/code | sed -E 's/:.*$//' | grep -v \"^$(tmux display-message -p '#S')\$\" | fzf --reverse)
selected_name=$(echo $selected | tr "." -)

if [ "$selected_name" = "" ]; then
    echo "Strings are equal."
else
	tmuxinator start $selected_name -n $selected_name -p ~/dotfiles/default.yml workspace="~/code/${selected}"
fi
