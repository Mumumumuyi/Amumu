#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
web-reader - 网页内容读取与整理工具
功能: 从网址读取网页内容，整理并保存到指定文件夹
用法: python web_reader.py "https://example.com"
"""

import sys
import os
import json
import argparse
from datetime import datetime
from pathlib import Path

try:
    import requests
    from bs4 import BeautifulSoup
    from urllib.parse import urlparse
except ImportError as e:
    print(f"缺少依赖库: {e}")
    print("请安装: pip install requests beautifulsoup4")
    sys.exit(1)


class WebReader:
    """网页内容读取器"""

    def __init__(self):
        self.session = requests.Session()
        self.session.headers.update({
            'User-Agent': 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36'
        })

    def fetch_page(self, url):
        """获取网页内容"""
        try:
            response = self.session.get(url, timeout=30, allow_redirects=True)
            response.raise_for_status()
            response.encoding = response.apparent_encoding
            return response.text, response.url
        except Exception as e:
            raise Exception(f"获取网页失败: {e}")

    def parse_content(self, html, base_url):
        """解析网页内容"""
        soup = BeautifulSoup(html, 'html.parser')

        # 移除不需要的标签
        for tag in soup(['script', 'style', 'nav', 'footer', 'header', 'iframe', 'noscript']):
            tag.decompose()

        # 提取信息
        data = {
            'title': self._get_title(soup),
            'url': base_url,
            'meta': self._get_meta(soup),
            'headings': self._get_headings(soup),
            'main_content': self._get_main_content(soup),
            'links': self._get_links(soup, base_url),
            'images': self._get_images(soup, base_url),
        }

        return data

    def _get_title(self, soup):
        """获取页面标题"""
        title_tag = soup.find('title')
        return title_tag.get_text(strip=True) if title_tag else "无标题"

    def _get_meta(self, soup):
        """获取元数据"""
        meta = {}
        for tag in soup.find_all('meta'):
            name = tag.get('name') or tag.get('property')
            if name in ['description', 'keywords', 'author']:
                meta[name] = tag.get('content', '')
        return meta

    def _get_headings(self, soup):
        """获取标题结构"""
        headings = []
        level_map = {'h1': 1, 'h2': 2, 'h3': 3, 'h4': 4, 'h5': 5, 'h6': 6}
        for tag in soup.find_all(['h1', 'h2', 'h3', 'h4', 'h5', 'h6']):
            headings.append({
                'level': level_map.get(tag.name, 0),
                'text': tag.get_text(strip=True)
            })
        return headings

    def _get_main_content(self, soup):
        """获取主要内容"""
        # 优先获取 main 或 article 标签
        main_content = (soup.find('main') or
                       soup.find('article') or
                       soup.find('div', class_=lambda x: x and ('content' in x.lower() or 'article' in x.lower())))

        if not main_content:
            main_content = soup.body or soup

        # 提取段落文本
        paragraphs = []
        for p in main_content.find_all('p'):
            text = p.get_text(strip=True)
            if text:
                paragraphs.append(text)

        return '\n\n'.join(paragraphs) if paragraphs else "未找到主要内容"

    def _get_links(self, soup, base_url):
        """获取页面链接"""
        links = []
        for a in soup.find_all('a', href=True):
            href = a['href']
            text = a.get_text(strip=True)[:100]
            if text and not href.startswith(('javascript:', '#', 'mailto:', 'tel:')):
                links.append({'text': text, 'href': href})
        return links[:50]  # 限制数量

    def _get_images(self, soup, base_url):
        """获取图片信息"""
        from urllib.parse import urljoin

        images = []
        for img in soup.find_all('img'):
            src = img.get('src') or img.get('data-src')
            if src:
                full_url = urljoin(base_url, src)
                alt = img.get('alt', '')
                images.append({'src': full_url, 'alt': alt})
        return images[:20]  # 限制数量

    def format_output(self, data, format_type='md'):
        """格式化输出内容"""
        timestamp = datetime.now().strftime('%Y-%m-%d %H:%M:%S')

        if format_type == 'md':
            return self._format_markdown(data, timestamp)
        elif format_type == 'txt':
            return self._format_text(data, timestamp)
        elif format_type == 'json':
            return json.dumps(data, ensure_ascii=False, indent=2)
        else:
            raise ValueError(f"不支持的格式: {format_type}")

    def _format_markdown(self, data, timestamp):
        """生成 Markdown 格式"""
        md = []
        md.append(f"# {data['title']}\n")
        md.append(f"**URL:** {data['url']}")
        md.append(f"**采集时间:** {timestamp}\n")
        md.append("---\n")

        if data['meta'].get('description'):
            md.append(f"**摘要:** {data['meta']['description']}\n")

        if data['headings']:
            md.append("## 目录\n")
            for h in data['headings']:
                indent = "  " * (h['level'] - 1)
                md.append(f"{indent}- {h['text']}")
            md.append("\n---\n")

        md.append("## 正文内容\n")
        md.append(data['main_content'])
        md.append("\n---\n")

        if data['links']:
            md.append(f"## 参考链接 ({len(data['links'])} 个)\n")
            for link in data['links'][:20]:
                md.append(f"- [{link['text']}]({link['href']})")
            md.append("\n")

        if data['images']:
            md.append(f"## 相关图片 ({len(data['images'])} 张)\n")
            for img in data['images'][:10]:
                alt = img['alt'] or '图片'
                md.append(f"- ![{alt}]({img['src']})")
            md.append("\n")

        return '\n'.join(md)

    def _format_text(self, data, timestamp):
        """生成纯文本格式"""
        txt = []
        txt.append(f"标题: {data['title']}")
        txt.append(f"URL: {data['url']}")
        txt.append(f"采集时间: {timestamp}")
        txt.append("=" * 60 + "\n")

        if data['meta'].get('description'):
            txt.append(f"摘要: {data['meta']['description']}\n")

        if data['headings']:
            txt.append("目录:")
            for h in data['headings']:
                indent = "  " * (h['level'] - 1)
                txt.append(f"{indent}- {h['text']}")
            txt.append("\n" + "-" * 60 + "\n")

        txt.append("正文内容:")
        txt.append("-" * 60)
        txt.append(data['main_content'])
        txt.append("\n" + "-" * 60 + "\n")

        if data['links']:
            txt.append(f"参考链接 ({len(data['links'])} 个):")
            for link in data['links'][:20]:
                txt.append(f"  - {link['text']}: {link['href']}")
            txt.append("\n")

        return '\n'.join(txt)

    def get_filename(self, url, format_type):
        """生成文件名"""
        parsed = urlparse(url)
        domain = parsed.netloc.replace('www.', '')
        clean_title = ''.join(c for c in domain if c.isalnum() or c in '-_')
        timestamp = datetime.now().strftime('%Y%m%d_%H%M%S')
        ext = {'md': '.md', 'txt': '.txt', 'json': '.json'}.get(format_type, '.txt')
        return f"{clean_title}_{timestamp}{ext}"


def ask_save_location():
    """询问用户保存位置"""
    print("\n" + "=" * 50)
    print("请选择保存位置:")
    print("=" * 50)
    print("1. 当前目录")
    print("2. 桌面")
    print("3. 文档文件夹")
    print("4. 自定义路径")
    print("=" * 50)

    while True:
        try:
            choice = input("\n请输入选项 (1-4): ").strip()

            if choice == '1':
                return Path.cwd()
            elif choice == '2':
                desktop = Path.home() / 'Desktop'
                if desktop.exists():
                    return desktop
                return Path.home() / '桌面'
            elif choice == '3':
                docs = Path.home() / 'Documents'
                if docs.exists():
                    return docs
                return Path.home() / '文档'
            elif choice == '4':
                custom = input("请输入保存路径: ").strip()
                return Path(custom)
            else:
                print("无效选项，请重新输入 (1-4)")
        except (EOFError, KeyboardInterrupt):
            print("\n操作已取消")
            sys.exit(0)


def ask_format():
    """询问用户保存格式"""
    print("\n请选择保存格式:")
    print("1. Markdown (.md) - 推荐，格式美观")
    print("2. 纯文本 (.txt)")
    print("3. JSON (.json) - 结构化数据")

    while True:
        choice = input("请输入选项 (1-3, 默认1): ").strip() or "1"

        if choice == '1':
            return 'md'
        elif choice == '2':
            return 'txt'
        elif choice == '3':
            return 'json'
        else:
            print("无效选项，请重新输入 (1-3)")


def save_content(content, filename, save_dir):
    """保存内容到文件"""
    save_dir = Path(save_dir)
    save_dir.mkdir(parents=True, exist_ok=True)
    filepath = save_dir / filename

    with open(filepath, 'w', encoding='utf-8') as f:
        f.write(content)

    return filepath


def main():
    parser = argparse.ArgumentParser(description='网页内容读取与整理工具')
    parser.add_argument('url', help='要读取的网页网址')
    parser.add_argument('-f', '--format', choices=['md', 'txt', 'json'],
                        default='md', help='输出格式 (默认: md)')
    parser.add_argument('-o', '--output', help='保存路径（跳过询问）')

    args = parser.parse_args()

    print(f"\n🌐 正在读取网页: {args.url}")

    # 创建读取器
    reader = WebReader()

    # 获取网页内容
    try:
        html, final_url = reader.fetch_page(args.url)
        print("✓ 网页获取成功")
    except Exception as e:
        print(f"✗ {e}")
        return 1

    # 解析内容
    try:
        data = reader.parse_content(html, final_url)
        print(f"✓ 解析完成: {data['title']}")
    except Exception as e:
        print(f"✗ 解析失败: {e}")
        return 1

    # 询问保存位置
    if args.output:
        save_dir = Path(args.output)
    else:
        save_dir = ask_save_location()

    # 询问格式（如果没有指定）
    format_type = args.format
    if not args.output:
        format_type = ask_format()

    # 格式化内容
    try:
        content = reader.format_output(data, format_type)
        print("✓ 内容整理完成")
    except Exception as e:
        print(f"✗ 格式化失败: {e}")
        return 1

    # 生成文件名
    filename = reader.get_filename(final_url, format_type)

    # 保存文件
    try:
        filepath = save_content(content, filename, save_dir)
        print(f"\n✓ 文件已保存: {filepath}")
        print(f"  大小: {len(content)} 字符")
        return 0
    except Exception as e:
        print(f"✗ 保存失败: {e}")
        return 1


if __name__ == "__main__":
    try:
        sys.exit(main())
    except KeyboardInterrupt:
        print("\n\n操作已取消")
        sys.exit(0)
    except Exception as e:
        print(f"\n✗ 错误: {e}")
        sys.exit(1)
