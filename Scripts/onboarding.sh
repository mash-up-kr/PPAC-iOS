
curl https://mise.run | sh
echo 'eval "$(~/.local/bin/mise activate bash)"' >> ~/.bashrc
# note that bash will read from ~/.profile or ~/.bash_profile if the latter exists
# ergo, you may want to check to see which is defined on your system and only append to the existing file
echo 'export PATH="$HOME/.local/share/mise/shims:$PATH"' >> ~/.bash_profile

# echo 'eval "$(~/.local/bin/mise activate zsh)"' >> ~/.zshrc
# echo 'export PATH="$HOME/.local/share/mise/shims:$PATH"' >> ~/.zprofile
# if ! grep -q 'eval "$(~/.local/bin/mise activate zsh)"' ~/.zshrc; then
#   echo 'eval "$(~/.local/bin/mise activate zsh)"' >> ~/.zshrc
# fi

