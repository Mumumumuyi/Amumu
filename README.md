# 👋 Amumu's Skills & Tools

> 收集和分享实用的开发工具和技能

![GitHub stars](https://img.shields.io/github/stars/Mumumumuyi/Amumu?style=social)
![GitHub forks](https://img.shields.io/github/forks/Mumumumuyi/Amumu?style=social)
![License](https://img.shields.io/github/license/Mumumumuyi/Amumu)

## 资源总览

| 工具 | 说明 | 斜杠命令 |
|------|------|----------|
| [Web-Search](#🔍-web-search-网络搜索工具) | 浏览器快速搜索 | `/search` |
| [Web-Reader](#📖-web-reader-网页内容读取工具) | 网页内容读取保存 | `/read` |

---

## 🔍 Web-Search 网络搜索工具

在默认浏览器中快速打开 Google 搜索。

### 特性
- ✅ 跨平台支持（Windows / macOS / Linux）
- ✅ 自动 URL 编码，支持中文搜索
- ✅ 多种运行方式

### 使用方法

```cmd
# Windows
powershell -ExecutionPolicy Bypass -File web_search.ps1 "搜索关键词"

# 快捷命令
search.bat 搜索关键词
```

👉 [完整文档](./skills/web-search/README.md)

---

## 📖 Web-Reader 网页内容读取工具

从网址读取网页内容，整理后保存到指定位置。

### 特性
- ✅ 自动提取标题、正文内容
- ✅ 交互式选择保存位置
- ✅ 多种保存格式（Markdown / 纯文本 / JSON）
- ✅ 支持保存前询问用户

### 使用方法

```powershell
# 交互式使用（会询问保存位置）
powershell -ExecutionPolicy Bypass -File web_reader.ps1 "https://example.com"

# 指定保存路径
powershell -ExecutionPolicy Bypass -File web_reader.ps1 -Url "https://example.com" -Output "C:\Documents"

# 指定格式
powershell -ExecutionPolicy Bypass -File web_reader.ps1 -Url "https://example.com" -Format md
```

### 交互式选项

运行后会询问：

1. **保存位置**
   - 当前目录
   - 桌面
   - 文档文件夹
   - 自定义路径

2. **保存格式**
   - Markdown (.md) - 推荐
   - 纯文本 (.txt)
   - JSON (.json)

👉 [完整文档](./skills/web-reader/README.md)

---

## 📦 计划添加

- [ ] Git 快捷命令工具
- [ ] Docker 容器管理脚本
- [ ] 项目模板生成器
- [ ] 代码格式化工具

---

## 🤝 贡献

欢迎提交 Issue 和 Pull Request！

## 📄 许可证

MIT License

---

**Made with ❤️ by [Amumu](https://github.com/Mumumumuyi)**
