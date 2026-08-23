alias clauded="claude --dangerously-skip-permissions"
alias forgec="~/.local/bin/forge"
# 只展示存在未提交变更的一级 Git 仓库
git-dirty-repos() {
    for d in */; do
        if [ -d "$d/.git" ]; then
            # 检查是否有变更
            if git -C "$d" status --porcelain | grep -q .; then
                echo -e "\n===== 📂 $d ====="
                git -C "$d" status --short
            fi
        fi
    done
}
git-pull-all() {
    for d in */; do
        if [ -d "$d/.git" ]; then
            branch=$(git -C "$d" rev-parse --abbrev-ref HEAD)
            echo -e "\n===== 📂 $d [${branch}] ====="
            git -C "$d" pull
        fi
    done
}