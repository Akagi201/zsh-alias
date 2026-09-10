# zsh-alias

Categorize my own zsh aliases

## Tools

* [ls](ls.zsh): modern replacement for `ls`.
* [proxy](proxy.zsh): terminal proxy config.
* [cargo](cargo.zsh): cargo command aliases.
* [python](python.zsh): python and uv aliases.
* [editor](editor.zsh): editor aliases.

## Usage

### Install missing tools

macOS:

```bash
brew install eza
brew install erdtree
```

Linux:

```bash
# Debian/Ubuntu
sudo apt install eza erdtree
# 或用 Homebrew on Linux
brew install eza erdtree
```

### Install alias plugin

```bash
git clone https://github.com/Akagi201/zsh-alias.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-alias
```

Add `zsh-alias` to the `plugins` list in your `.zshrc`

```bash
plugins=(... zsh-alias)
```
