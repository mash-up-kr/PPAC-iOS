
curl https://mise.run | sh
echo 'eval "$(~/.local/bin/mise activate zsh)"' >> ~/.zshrc
echo 'export PATH="$HOME/.local/share/mise/shims:$PATH"' >> ~/.zprofile
# if ! grep -q 'eval "$(~/.local/bin/mise activate zsh)"' ~/.zshrc; then
#   echo 'eval "$(~/.local/bin/mise activate zsh)"' >> ~/.zshrc
# fi

