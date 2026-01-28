# 👋 Amumu's Skills & Tools

> 收集和分享实用的开发工具和技能

![GitHub stars](https://img.shields.io/github/stars/Mumumumuyi/Amumu?style=social)
![GitHub forks](https://img.shields.io/github/forks/Mumumumuyi/Amumu?style=social)
![License](https://img.shields.io/github/license/Mumumumuyi/Amumu)

## 📦 目录

- [Web-Search](#🔍-web-search-网络搜索工具) - 在默认浏览器中快速打开 Google 搜索

---

## 🔍 Web-Search 网络搜索工具

一个轻量级的命令行工具，可以在默认浏览器中快速打开 Google 搜索页面，支持跨平台使用。

### 特性

- ✅ 跨平台支持（Windows / macOS / Linux）
- ✅ 自动 URL 编码，支持中文搜索
- ✅ 多种运行方式（Python / PowerShell / Bash / 批处理）
- ✅ 可配置为 Claude Code 斜杠命令

### 安装使用

#### Windows (PowerShell)

```powershell
powershell -ExecutionPolicy Bypass -File web_search.ps1 "搜索关键词"
```

#### Windows (批处理)

```cmd
search.bat 搜索关键词
```

#### Python (通用)

```python
python web_search.py "搜索关键词"
```

#### Linux / macOS

```bash
./web_search.sh "搜索关键词"
```

### 配置为快捷命令

在 PowerShell 配置文件 (`$PROFILE`) 中添加别名：

```powershell
function Search {
    param([Parameter(ValueFromRemainingArguments)][string[]]$Keywords)
    $query = $Keywords -join " "
    Start-Process "https://www.google.com/search?q=$( [uri]::EscapeDataString($query) )"
}
Set-Alias -Name search -Value Search
```

然后就可以用 `search 搜索词` 快速搜索了！

### 文件说明

| 文件 | 平台 | 说明 |
|------|------|------|
| `web_search.py` | 跨平台 | Python 版本 |
| `web_search.ps1` | Windows | PowerShell 版本 |
| `web_search.bat` | Windows | 批处理版本 |
| `search.bat` | Windows | 简化快捷命令 |
| `web_search.sh` | Linux/macOS | Bash 版本 |

### 详细文档

👉 [完整使用文档](./skills/web-search/README.md)

---

## 📦 技能扩展

本仓库计划收集更多实用工具，欢迎贡献！

### 计划添加

- [ ] Git 快捷命令工具
- [ ] Docker 容器管理脚本
- [ ] 项目模板生成器
- [ ] 代码格式化工具

---

## 🤝 贡献

欢迎提交 Issue 和 Pull Request！

## 📄 许可证

MIT License - 详见 [LICENSE](./LICENSE) 文件

---

**Made with ❤️ by [Amumu](https://github.com/Mumumumuyi)**
