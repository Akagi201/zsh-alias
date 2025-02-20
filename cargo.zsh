alias cg=cargo
alias cgr='cargo run'
alias cgc='cargo check'
alias cgcl='cargo clean'
alias cgd='cargo doc'
alias cgn='cargo new'
alias cgt='cargo test -- --nocapture'
alias cgnt='cargo nextest run -r --no-capture'
alias cgcp='cargo +nightly clippy --all'
alias cgcpw='cargo +nightly clippy -- -W clippy::all -W clippy::pedantic -W clippy::nursery'
alias cgf='cargo +nightly fmt --all'
alias cgb='cargo build'
alias cga='cargo add'
alias cgu='cargo update'
alias cgs='cargo search'
alias cgp='cargo publish'
alias cgi='cargo install'
alias cgui='cargo uninstall'
alias cgbr='cargo build --release'
alias cgiu='cargo install-update -ag'
rm_cargo_cache() {
  rm -rf ~/.cargo/registry/index/* ~/.cargo/.package-cache
}
