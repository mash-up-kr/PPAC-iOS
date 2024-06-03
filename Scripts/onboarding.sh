#!/bin/bash

# Install mise
curl https://mise.run | sh

# Check mise version
~/.local/bin/mise --version

# Set up mise environment for bash
echo 'eval "$(~/.local/bin/mise activate bash)"' >> ~/.bashrc

# Ensure the mise environment is set up for the current session
eval "$(~/.local/bin/mise activate bash)"

# Set up PATH for mise
echo 'export PATH="$HOME/.local/share/mise/shims:$PATH"' >> ~/.bash_profile

# Ensure PATH is set up for the current session
export PATH="$HOME/.local/share/mise/shims:$PATH"

# Uncomment and set up for zsh if needed
# echo 'eval "$(~/.local/bin/mise activate zsh)"' >> ~/.zshrc
# echo 'export PATH="$HOME/.local/share/mise/shims:$PATH"' >> ~/.zprofile
# if ! grep -q 'eval "$(~/.local/bin/mise activate zsh)"' ~/.zshrc; then
#   echo 'eval "$(~/.local/bin/mise activate zsh)"' >> ~/.zshrc
# fi
