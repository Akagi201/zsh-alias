# ==============================================================================
# eza aliases (Replacement for ls)
# 依赖: brew install eza
# 建议: 终端需使用 Nerd Font 字体以正常显示图标
# ==============================================================================

# 基础 ls (带有图标和目录优先)
alias ls='eza --icons=auto --group-directories-first'

# 紧凑列表查看 (权限、八进制、大小、Git，隐藏用户和时间)
alias l='eza -lbhF --icons=auto --git --group-directories-first --no-user --no-time --octal-permissions'
alias la='eza -lbhaF --icons=auto --git --group-directories-first --no-user --no-time --octal-permissions'

# 全量信息查看 (当需要排查时间和用户归属时使用)
alias ll='eza -lhaF --icons=auto --git --group-directories-first --octal-permissions'

# 单列纯净查看 (常用于复制文件名)
alias l1='eza -1 --icons=never --group-directories-first'

# 树状视图 (限制2层，带图标)
alias lt='eza --tree --level=2 --icons=auto --group-directories-first'

# 仅查看目录 (过滤掉文件，非常实用)
alias ld='eza -lD --icons=auto --group-directories-first'

# 原生 ls 降级方案 (防止偶尔需要 macOS 原生 ls 的行为)
alias lsn='\ls -G' 

# ==============================================================================
# erd aliases (Rust alternative to tree)
# ==============================================================================
# 你的 erd 配置非常专业，结合了人类可读、八进制和逻辑排序，保留即可。
alias tree='erd -L 1 -H -. -i --octal -l --dir-order last -y inverted -d logical'