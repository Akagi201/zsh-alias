# upgrade.sh - cross-platform system/tool upgrade (macOS + Arch Linux)
#
# Usage: `up` upgrades system packages + language toolchains.
# OS-specific bits are detected at runtime via `uname -s` / /etc/os-release,
# so this file is safe to source on both macOS and Arch Linux.

# --- helpers (underscore-prefixed to avoid polluting the shell) ---
_upgrade_has() {
    command -v "$1" >/dev/null 2>&1
}

# _upgrade_step <label> <cmd...>: run an upgrade step, keep going on failure.
_upgrade_step() {
    local label="$1"
    shift
    echo "==> ${label}"
    "$@" || echo "!! '${label}' failed (exit $?), continuing..."
}

_upgrade_is_arch() {
    [ -f /etc/os-release ] && grep -qiE '^ID(_LIKE)?=.*arch' /etc/os-release
}

# --- cross-platform aliases ---
alias fabric='fabric-ai'

# --- macOS-only aliases ---
case "$(uname -s)" in
Darwin)
    alias flushdns='sudo dscacheutil -flushcache; sudo killall -HUP mDNSResponder'
    alias showfiles='defaults write com.apple.finder AppleShowAllFiles -bool true && killall Finder'
    alias hidefiles='defaults write com.apple.finder AppleShowAllFiles -bool false && killall Finder'
    alias tailscale='/Applications/Tailscale.app/Contents/MacOS/Tailscale'
    ;;
esac

# --- package-manager upgrades ---
# Homebrew (macOS, also works as Linuxbrew). Fixed: `brew upgrade` takes no -y flag.
brewup() {
    if ! _upgrade_has brew; then
        echo "brew not found, skipping brewup."
        return 0
    fi
    brew update && brew upgrade && brew cleanup
}

uvup() {
    if ! _upgrade_has uv; then
        echo "uv not found, skipping uvup."
        return 0
    fi
    uv self update
}

# Arch Linux: pacman + AUR helper (paru/yay) when available, plus flatpak.
archup() {
    if _upgrade_has paru; then
        _upgrade_step "paru -Syu" paru -Syu
    elif _upgrade_has yay; then
        _upgrade_step "yay -Syu" yay -Syu
    elif _upgrade_has pacman; then
        _upgrade_step "pacman -Syu" sudo pacman -Syu
    else
        echo "neither paru/yay/pacman found, skipping Arch system upgrade."
    fi
    if _upgrade_has flatpak; then
        _upgrade_step "flatpak update" flatpak update -y
    fi
}

srsync() {
    if [ "$#" -lt 2 ]; then
        echo "Usage: srsync <source file/directory> <destination path>"
        echo "Example: srsync ./config.yml user@host:/etc/config/"
        return 1
    fi
    rsync -av --rsync-path="sudo rsync" "$@"
}

up() {
    # 1. oh-my-zsh
    if _upgrade_has omz; then
        _upgrade_step "omz update" omz update
    fi

    # 2. OS-specific system packages
    case "$(uname -s)" in
    Darwin)
        _upgrade_step "brewup" brewup
        ;;
    Linux)
        if _upgrade_is_arch || _upgrade_has pacman || _upgrade_has paru || _upgrade_has yay; then
            _upgrade_step "archup" archup
        fi
        # Linuxbrew, if installed alongside pacman
        if _upgrade_has brew; then
            _upgrade_step "brewup" brewup
        fi
        ;;
    *)
        echo "Unknown OS '$(uname -s)', skipping system package upgrade."
        ;;
    esac

    # 3. Cross-platform language/toolchain upgrades (each guarded, failures don't abort)
    if _upgrade_has uv; then
        _upgrade_step "uv self update" uv self update
    fi
    if _upgrade_has curl; then
        _upgrade_step "bun install" sh -c 'curl -fsSL https://bun.com/install | bash'
    fi
    if _upgrade_has rustup; then
        _upgrade_step "rustup update" rustup update
        # Prune old dated toolchains, keep only stable/nightly.
        # Portable: only call xargs when there is something to uninstall
        # (macOS xargs has no -r/--no-run-if-empty).
        _old_toolchains=$(rustup toolchain list | grep -vE 'stable|nightly' | awk '{print $1}')
        if [ -n "${_old_toolchains}" ]; then
            echo "==> rustup prune old toolchains"
            echo "${_old_toolchains}" | xargs rustup toolchain uninstall || echo "!! 'rustup prune' failed, continuing..."
        fi
        unset _old_toolchains
    fi
    if _upgrade_has foundryup; then
        _upgrade_step "foundryup" foundryup
    fi
    if _upgrade_has gcloud; then
        _upgrade_step "gcloud components update" gcloud components update -q
    fi
    if _upgrade_has goose; then
        _upgrade_step "goose update" goose update
    fi
    if _upgrade_has gh; then
        _upgrade_step "gh extensions" gh extension upgrade --all
    fi
    if _upgrade_has fabric || _upgrade_has fabric-ai; then
        _upgrade_step "fabric -U" fabric -U
    fi
    if _upgrade_has agave-install; then
        _upgrade_step "agave-install update" agave-install update
    fi
    if _upgrade_has uv; then
        _upgrade_step "uv tool upgrade" uv tool upgrade --all
    fi
    if _upgrade_has npm; then
        _upgrade_step "npm update -g" npm update -g
    fi
    if _upgrade_has gup; then
        _upgrade_step "gup update" gup update
    fi
    if _upgrade_has bun; then
        _upgrade_step "bun update -g" bun update -g --latest
    fi
    if _upgrade_has proto; then
        _upgrade_step "proto outdated" proto outdated --config-mode global --update --latest --yes
        _upgrade_step "proto install" proto install --config-mode global
    fi
    if _upgrade_has npx; then
        _upgrade_step "skills update" npx -y skills update -g -y
    fi
}
