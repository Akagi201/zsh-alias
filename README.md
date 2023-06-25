# zsh-alias

Categorize my own zsh aliases

## Tools

* [exa](exa.zsh): modern replacement for `ls`.
* [proxy](proxy.zsh): terminal proxy config.
* [cargo](cargo.zsh): cargo command aliases.

## Usage

### Install missing tools

```bash
brew install exa
brew install erdtree
```

### Install alias plugin

```bash
git clone https://github.com/Akagi201/zsh-alias.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-alias
```

Add `zsh-alias` to the `plugins` list in your `.zshrc`

```bash
plugins=(... zsh-alias)
```
