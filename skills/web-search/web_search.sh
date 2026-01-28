#!/bin/bash
# web-search.sh - 在默认浏览器中打开 Google 搜索
# 用法: ./web-search.sh "搜索关键词"

# 如果没有参数，提示输入
if [ $# -eq 0 ]; then
    read -p "请输入搜索关键词: " QUERY
    if [ -z "$QUERY" ]; then
        echo "未输入搜索关键词!"
        exit 1
    fi
else
    QUERY="$*"
fi

# URL 编码
ENCODED=$(python3 -c "import urllib.parse; print(urllib.parse.quote_plus('$QUERY'))" 2>/dev/null || echo "$QUERY" | tr ' ' '+')

URL="https://www.google.com/search?q=${ENCODED}"

echo "正在搜索: $QUERY"
echo "URL: $URL"

# 根据操作系统打开浏览器
case "$(uname -s)" in
    Linux*)
        xdg-open "$URL" 2>/dev/null || sensible-browser "$URL"
        ;;
    Darwin*)
        open "$URL"
        ;;
    CYGWIN*|MINGW*|MSYS*)
        start "$URL"
        ;;
    *)
        echo "不支持的操作系统"
        exit 1
        ;;
esac

echo "浏览器已打开"
