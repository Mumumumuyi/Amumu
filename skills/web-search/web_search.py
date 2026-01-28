#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
web-search - 在默认浏览器中打开 Google 搜索
跨平台支持: Windows / macOS / Linux
用法: python web_search.py "搜索关键词"
"""

import sys
import urllib.parse
import webbrowser
import subprocess


def open_browser(url):
    """跨平台打开浏览器"""
    try:
        webbrowser.open(url)
        return True
    except Exception:
        try:
            # 备用方案：使用系统命令
            import platform
            os_type = platform.system()
            if os_type == "Windows":
                subprocess.run(["start", "", url], shell=True, timeout=5)
            elif os_type == "Darwin":  # macOS
                subprocess.run(["open", url], timeout=5)
            else:  # Linux
                subprocess.run(["xdg-open", url], timeout=5)
            return True
        except Exception as e:
            print(f"无法打开浏览器: {e}")
            return False


def main():
    # 获取搜索关键词
    if len(sys.argv) > 1:
        query = " ".join(sys.argv[1:])
    else:
        query = input("请输入搜索关键词: ").strip()
        if not query:
            print("未输入搜索关键词!")
            return 1

    # URL 编码查询字符串
    encoded_query = urllib.parse.quote_plus(query)
    url = f"https://www.google.com/search?q={encoded_query}"

    print(f"正在搜索: {query}")
    print(f"URL: {url}")

    if open_browser(url):
        print("✓ 浏览器已打开")
        return 0
    else:
        print("✗ 无法打开浏览器")
        print(f"请手动访问: {url}")
        return 1


if __name__ == "__main__":
    sys.exit(main())
