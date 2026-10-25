#!/bin/bash
# 巡星记 · 局域网访问服务器（macOS）
# 双击本文件即可运行；请保持这个窗口开着。

cd "$(dirname "$0")" || exit 1
PORT=8080

# 找一个可用的 Python
PY=""
for c in python3 /usr/bin/python3 python; do
  if command -v "$c" >/dev/null 2>&1; then PY="$c"; break; fi
done

clear
echo "=================================================="
echo "          巡星记 · 局域网访问服务器"
echo "=================================================="
echo ""

IP=$(ipconfig getifaddr en0 2>/dev/null)
[ -z "$IP" ] && IP=$(ipconfig getifaddr en1 2>/dev/null)
[ -z "$IP" ] && IP=$(ifconfig 2>/dev/null | grep 'inet ' | grep -v 127.0.0.1 | awk '{print $2}' | head -n1)

if [ -n "$IP" ]; then
  echo "  在平板的浏览器（Safari / Chrome）里，"
  echo "  输入下面这个地址，然后回车："
  echo ""
  echo "        http://$IP:$PORT"
  echo ""
else
  echo "  [!] 没找到局域网 IP。"
  echo "      请先确认这台电脑已经连上家里的 Wi-Fi。"
  echo ""
fi

echo "  --------------------------------------------------"
echo "  这个窗口要一直开着；关掉它，服务就停了。"
echo "  --------------------------------------------------"
echo ""

if [ -z "$PY" ]; then
  echo "  [x] 没有找到 Python。"
  echo "      Mac 一般自带，若确实没有，请到 https://www.python.org 安装后重试。"
  echo ""
  read -n1 -r -p "  按任意键关闭..."
  exit 1
fi

echo "  服务已启动，等待平板连接..."
echo ""
"$PY" -m http.server "$PORT"
