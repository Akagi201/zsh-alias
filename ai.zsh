tsay() {
    # macOS 原生 TTS
    if [[ "$(uname -s)" == "Darwin" ]]; then
        tee /dev/tty | say -v Meijia
        return
    fi
    # Linux fallback: espeak 支持 stdin 管道，spd-say 需要参数形式
    if command -v espeak >/dev/null 2>&1; then
        tee /dev/tty | espeak
    elif command -v spd-say >/dev/null 2>&1; then
        tee /dev/tty | xargs -r -I{} spd-say "{}"
    else
        tee /dev/tty >/dev/null
        echo "tsay: no TTS backend found (espeak/spd-say)" >&2
        return 1
    fi
}
