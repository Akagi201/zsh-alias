alias brewup='brew update && brew upgrade && brew upgrade --cask && brew cleanup'
alias uvup='uv self update'
alias flushdns='sudo dscacheutil -flushcache; sudo killall -HUP mDNSResponder'
alias showfiles='defaults write com.apple.finder AppleShowAllFiles -bool true && killall Finder'
alias hidefiles='defaults write com.apple.finder AppleShowAllFiles -bool false && killall Finder'
alias tailscale='/Applications/Tailscale.app/Contents/MacOS/Tailscale'
up() {
  brewup
  uvup
  bun upgrade
  rustup update
  mise upgrade
  foundryup
  gcloud components update -q
  goose update
  gh extension upgrade --all
  agave-install update
  uv tool upgrade --all
  cargo install --git https://github.com/leptos-rs/cargo-leptos --locked cargo-leptos
}
