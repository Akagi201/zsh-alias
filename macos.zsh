alias brewup='brew update && brew upgrade && brew upgrade --cask && brew cleanup'
alias uvup='uv self update'
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
}
