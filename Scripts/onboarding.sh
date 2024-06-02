if ! command -v brew &> /dev/null; then
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi


if ! command -v mise &> /dev/null; then
  echo "\n[7] > Installing mise ...\n"
  curl https://mise.run | sh
fi

# if ! grep -q 'eval "$(~/.local/bin/mise activate zsh)"' ~/.zshrc; then
#   echo 'eval "$(~/.local/bin/mise activate zsh)"' >> ~/.zshrc
# fi

