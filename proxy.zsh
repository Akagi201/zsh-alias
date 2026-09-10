# clash proxy
# macOS 用本机回环地址，Linux 用局域网 IP 指向宿主机上的 clash
if [[ "$(uname -s)" == "Darwin" ]]; then
  alias proxyon='export https_proxy=http://127.0.0.1:7890 http_proxy=http://127.0.0.1:7890 all_proxy=socks5h://127.0.0.1:7890 no_proxy="localhost,127.0.0.1,::1,0.0.0.0,.local"'
else
  alias proxyon='export https_proxy=http://192.168.31.220:7890 http_proxy=http://192.168.31.220:7890 all_proxy=socks5h://192.168.31.220:7890 no_proxy="localhost,127.0.0.1,::1,0.0.0.0,.local"'
fi
alias proxyoff='unset https_proxy http_proxy all_proxy no_proxy'

# Discord 硬编码了 macOS .app 路径，仅在 macOS 上定义
if [[ "$(uname -s)" == "Darwin" ]]; then
  alias discord='/Applications/Discord.app/Contents/MacOS/Discord --proxy-server=socks5h://127.0.0.1:7890'
fi
