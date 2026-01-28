# Web-Reader 网页内容读取工具

一个实用的命令行工具，可以从网址读取网页内容，整理并保存到指定位置。

## 功能特点

- ✅ 支持读取任意公开网页内容
- ✅ 自动提取标题、正文、链接等信息
- ✅ 多种保存格式（Markdown / 纯文本 / JSON）
- ✅ 交互式选择保存位置
- ✅ 自动生成文件名（含时间戳）

## 文件说明

| 文件 | 平台 | 说明 |
|------|------|------|
| `web_reader.py` | 跨平台 | Python 版本，功能最完整 |
| `web_reader.ps1` | Windows | PowerShell 版本 |
| `web_reader.bat` | Windows | 批处理快捷启动 |

## 使用方法

### Python 版本（推荐，功能最完整）

```bash
# 基本用法
python web_reader.py "https://example.com"

# 指定保存格式
python web_reader.py "https://example.com" -f txt
python web_reader.py "https://example.com" -f json

# 指定保存路径（跳过询问）
python web_reader.py "https://example.com" -o "C:\Users\YourName\Downloads"
```

### PowerShell 版本

```powershell
# 基本用法
powershell -ExecutionPolicy Bypass -File web_reader.ps1 "https://example.com"

# 指定格式
powershell -ExecutionPolicy Bypass -File web_reader.ps1 -Url "https://example.com" -Format txt

# 指定保存路径
powershell -ExecutionPolicy Bypass -File web_reader.ps1 -Url "https://example.com" -Output "C:\Downloads"
```

### 批处理版本

```cmd
web-reader.bat "https://example.com"
```

## 交互式选项

运行脚本后，会按顺序询问：

### 1. 保存位置
```
==================================================
请选择保存位置:
==================================================
1. 当前目录
2. 桌面
3. 文档文件夹
4. 自定义路径
==================================================
```

### 2. 保存格式
```
请选择保存格式:
1. Markdown (.md) - 推荐，格式美观
2. 纯文本 (.txt)
3. JSON (.json) - 结构化数据
```

## 输出格式说明

### Markdown (.md)
```
# 网页标题

**URL:** https://example.com
**采集时间:** 2025-01-28 12:34:56

---

**摘要:** 网页描述信息...

## 目录
- 一级标题
  - 二级标题
    - 三级标题

---

## 正文内容
这里是网页的主要文字内容...

---

## 参考链接 (23 个)
- [链接文字](https://example.com/page)
```

### 纯文本 (.txt)
```
标题: 网页标题
URL: https://example.com
采集时间: 2025-01-28 12:34:56
============================================================

摘要: 网页描述信息...

============================================================
正文内容:
------------------------------------------------------------
这里是网页的主要文字内容...
------------------------------------------------------------
```

### JSON (.json)
```json
{
  "title": "网页标题",
  "url": "https://example.com",
  "timestamp": "2025-01-28 12:34:56",
  "content": "网页内容...",
  "htmlLength": 15234
}
```

## 依赖安装

Python 版本需要安装以下依赖：

```bash
pip install requests beautifulsoup4
```

## 文件命名规则

文件名格式：`域名_时间戳.扩展名`

示例：
- `example_com_20250128_123456.md`
- `github_io_20250128_123456.txt`
- `myblog_net_20250128_123456.json`

## 使用场景

- 💾 **保存文章**：想保存网页文章到本地
- 📚 **资料收集**：收集研究资料和参考文档
- 📝 **笔记整理**：将网页内容整理成笔记
- 🔄 **离线阅读**：获取网页内容供离线查看

## 示例

### 保存文章到桌面

```bash
python web_reader.py "https://example.com/article"
# 按提示选择 2（桌面）和 1（Markdown）
```

### 批量处理（需要编写脚本）

```bash
# 保存多个网页
for url in ("url1.com" "url2.com" "url3.com") {
    python web_reader.py $url -o "C:\MyCollection" -f md
}
```

## 常见问题

### Q: 无法读取某些网页？
A: 部分网站可能有防护措施，建议尝试：
1. 确认网址正确且可公开访问
2. 使用 Python 版本（功能更完整）
3. 某些动态网页需要使用浏览器扩展

### Q: 内容不完整？
A: 这是正常现象：
- 网页内容可能通过 JavaScript 动态加载
- 建议查看网页源码确认内容结构

### Q: 中文乱码？
A: 工具已适配常见编码，如仍有问题：
- 确认保存时使用 UTF-8 编码
- 检查原网页的字符集声明

## 许可证

MIT License
