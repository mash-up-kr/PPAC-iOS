#!/bin/zsh

set -e

# mise 설치
curl https://mise.run | sh

# 환경설정 추가
echo 'eval "$(~/.local/bin/mise activate zsh)"' >> ~/.zshrc
echo 'export PATH="$HOME/.local/share/mise/shims:$PATH"' >> ~/.zprofile

# zsh 다시 시작
exec zsh

# 필요한 도구 설치
arch -arm64 brew install pipenv fastlane

# fastlane 설정
fastlane match development --readonly
fastlane match appstore --readonly

# mise, tuist 설치
mise install
tuist install

# tuist generate 실행
tuist generate
