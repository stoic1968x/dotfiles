#!/bin/bash
set -euo pipefail
yay -Qqet > pacotes_de_topo.txt

CONFIG_DIRS=("swaync" "hypr" "pipewire" "gtk-3.0" "gtk-4.0" "rofi" "matugen" "wlogout" "kitty" "waybar" "Kvantum")

for dir in "${CONFIG_DIRS[@]}"; do
    rsync -av --delete "$HOME/.config/$dir/" "$HOME/Hyprland-Git/.config/$dir/"
done

for file in "$HOME/.zshrc" "$HOME/.zprofile" "$HOME/.gtkrc-2.0"; do
    rsync -av "$file" "$HOME/Hyprland-Git/$(basename "$file")"
done

cd "$HOME/Hyprland-Git"

if [[ -n $(git status -s) ]]; then
    COMMIT_MSG="Atualizar configs - $(date '+%Y-%m-%d %H:%M:%S')"
    git add .
    git commit -m "$COMMIT_MSG"
    git pull --rebase
    git push
    echo "✅ Commit e push realizados!"
else
    echo "ℹ️ Nenhuma alteração detectada."
fi
