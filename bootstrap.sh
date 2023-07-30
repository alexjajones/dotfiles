ln -s ~/dotfiles/.nvim ~/.config/nvim
ln -s ~/dotfiles/.tmux.conf ~/.config/.tmux.conf
ln -s ~/dotfiles/.project_switcher.sh ~/.project_switcher.sh

git clone --depth 1 https://github.com/wbthomason/packer.nvim\
 ~/.local/share/nvim/site/pack/packer/start/packer.nvim

nvim --headless -c 'autocmd User PackerComplete quitall' -c 'PackerSync'
