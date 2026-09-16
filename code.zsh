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
# 将存在未 push commit 的一级 Git 仓库逐个 push
git-push-all() {
    for d in */; do
        if [ -d "$d/.git" ]; then
            branch=$(git -C "$d" rev-parse --abbrev-ref HEAD)
            echo -e "\n===== 📂 $d [${branch}] ====="
            # 没有 upstream 时无法判断 ahead, 跳过并提示
            if ! git -C "$d" rev-parse --abbrev-ref --symbolic-full-name @{u} >/dev/null 2>&1; then
                echo "⚠️  no upstream, skip (先手动: git -C \"$d\" push -u origin ${branch})"
                continue
            fi
            ahead=$(git -C "$d" rev-list --count @{u}..HEAD)
            if [ "$ahead" -gt 0 ]; then
                echo "🚀 ${ahead} commit(s) to push..."
                git -C "$d" push
            else
                echo "✅ already up to date"
            fi
        fi
    done
}