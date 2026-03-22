alias brewup='brew update && brew upgrade && brew upgrade --cask && brew cleanup'
alias uvup='uv self update'
alias flushdns='sudo dscacheutil -flushcache; sudo killall -HUP mDNSResponder'
alias showfiles='defaults write com.apple.finder AppleShowAllFiles -bool true && killall Finder'
alias hidefiles='defaults write com.apple.finder AppleShowAllFiles -bool false && killall Finder'
alias tailscale='/Applications/Tailscale.app/Contents/MacOS/Tailscale'
alias fabric='fabric-ai'
up() {
  brewup
  uvup
  curl -fsSL https://bun.com/install | bash
  rustup update
  rustup toolchain list | grep -vE 'stable|nightly' | awk '{print $1}' | xargs rustup toolchain uninstall
  foundryup
  gcloud components update -q
  goose update
  gh extension upgrade --all
  fabric -U
  agave-install update
  uv tool upgrade --all
  npm update -g
  gup update
  proto upgrade
  proto outdated -c global --update --latest -y
  proto install -c global -y
  npx -y skills update
}
