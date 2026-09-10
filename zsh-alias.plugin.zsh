0=${(%):-%N}
source ${0:A:h}/ls.zsh
source ${0:A:h}/proxy.zsh
source ${0:A:h}/cargo.zsh
source ${0:A:h}/ai.zsh
source ${0:A:h}/editor.zsh
source ${0:A:h}/python.zsh
# macOS 专属命令 (brew/defaults/dscacheutil/.app 路径)，仅在 macOS 上加载
if [[ "$(uname -s)" == "Darwin" ]]; then
  source ${0:A:h}/macos.zsh
fi
source ${0:A:h}/git.zsh
source ${0:A:h}/code.zsh
