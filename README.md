# 编程工具集成

> 收集和分享实用的全栈开发工具和技能，支持 Claude Code 环境

![GitHub stars](https://img.shields.io/github/stars/Mumumumuyi/Amumu?style=social)
![GitHub forks](https://img.shields.io/github/forks/Mumumumuyi/Amumu?style=social)
![License](https://img.shields.io/github/license/Mumumumuyi/Amumu)

## 资源总览

### 命令行工具

| 工具 | 说明 | 斜杠命令 |
|------|------|----------|
| [Web-Search](#🔍-web-search-网络搜索工具) | 浏览器快速搜索 | `/search` |
| [Web-Reader](#📖-web-reader-网页内容读取工具) | 网页内容读取保存 | `/read` |
| [Skill-Composer](#🔀-skill-composer-skill组合器) | 链式调用多个skills | `/composer list` |

### Claude Code Skills

| Skill | 领域 | 说明 |
|-------|------|------|
| [Fullstack-Dev](#⚡-fullstack-dev-全栈开发集成skill) | 全栈开发 | 集成10个专业技能 |
| [Backend-Expert](#-backend-expert-后端开发) | 后端开发 | API/数据库/认证/容器化 |
| [Frontend-Expert](#frontend-expert-前端开发) | 前端开发 | React/状态管理/测试 |
| [Frontend-Design](#frontend-design-ui设计) | UI设计 | 高级视觉设计 |
| [Connect-Apps](#connect-apps-服务集成) | 服务集成 | Gmail/Slack/GitHub |
| [MCP-Builder](#mcp-builder-mcp服务器开发) | MCP开发 | 协议服务器构建 |
| [Webapp-Testing](#webapp-testing-e2e测试) | 自动化测试 | Playwright测试 |
| [Web-Artifacts-Builder](#web-artifacts-builder-single-file-html) | Artifacts | React+Tailwind单文件HTML |
| [Slack-GIF-Creator](#slack-gif-creator-gif创作) | GIF创作 | Slack动画GIF |

---

## 命令行工具

### 🔍 Web-Search 网络搜索工具

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

### 📖 Web-Reader 网页内容读取工具

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

👉 [完整文档](./skills/web-reader/README.md)

---

### 🔀 Skill-Composer Skill组合器

支持链式调用多个skills，前一个skill的输出作为下一个skill的输入。

### 特性
- ✅ 链式调用多个skills
- ✅ 混合注册模式（配置文件 + 自动发现）
- ✅ 预定义调用链
- ✅ 跨平台支持

### 使用方法

```bash
# 列出所有可用skills
python skill_composer.py list

# 列出预定义的调用链
python skill_composer.py chains

# 链式调用
python skill_composer.py chain web_search,web_reader "关键词"

# 运行预定义链
python skill_composer.py run search-and-read "关键词"
```

👉 [完整文档](./skills/skill-composer/README.md)

---

## Claude Code Skills

### ⚡ Fullstack-Dev 全栈开发集成skill

集成的全栈开发专业技能集，涵盖前后端、设计、测试等完整能力。

### 集成的技能

| 技能 | 领域 | 核心能力 |
|------|------|---------|
| **Backend-Expert** | 后端开发 | API设计、数据库、认证、容器化、配置管理 |
| **Connect-Apps** | 服务集成 | Gmail、Slack、GitHub等外部API集成 |
| **Frontend-Design** | UI设计 | 高级视觉设计、免AI生成审美、创意布局 |
| **Frontend-Expert** | 前端开发 | React组件、状态管理、构建工具、测试 |
| **MCP-Builder** | MCP开发 | Model Context Protocol服务器构建 |
| **Slack-GIF-Creator** | GIF创作 | Slack优化的动画GIF |
| **Webapp-Testing** | E2E测试 | Playwright自动化测试 |
| **Web-Artifacts-Builder** | Artifacts | React+Tailwind+shadcn/ui单文件HTML |
| **Web-Search** | 网络搜索 | 浏览器Google搜索 |
| **Web-Reader** | 内容抓取 | 网页内容解析与提取 |

### 开发工作流程

```
需求分析 → UI设计 → 前端开发 → 后端开发 → 服务集成 → 测试验证 → 文档整理
   │          │          │          │          │          │          │
   ▼          ▼          ▼          ▼          ▼          ▼          ▼
Frontend    Frontend   Frontend   Backend    Connect    Webapp    Web Search/
Design      Expert     Expert     Expert     Apps       Testing   Reader
```

👉 [完整文档](./skills/fullstack-dev/SKILL.md)

---

### Backend-Expert 后端开发

全栈后端工程师，专精 Node.js/TypeScript、Python、Go、Java。

### 核心能力
- API 开发（REST / GraphQL / gRPC）
- 数据库设计（MySQL / PostgreSQL / MongoDB / Redis）
- 认证与授权（JWT / OAuth2 / RBAC）
- 容器化部署（Docker / Kubernetes）

---

### Frontend-Expert 前端开发

React 前端工程师，专注 UI 组件开发。

### 核心能力
- React 生态系统（组件架构、状态管理）
- 构建工具（Vite / Webpack）
- 测试框架（Jest / Vitest / Playwright）
- 样式方案（Tailwind / styled-components / shadcn/ui）

---

### Frontend-Design UI设计

创建独特、生产级的前端界面，避免"AI slop"审美。

### 核心能力
- 设计思维与风格定义
- 高级视觉设计
- 创意布局与动效

---

### Connect-Apps 服务集成

连接 Claude 到 Gmail、Slack、GitHub 等外部应用。

### 核心能力
- 发送邮件
- 发送 Slack 消息
- 创建 Issue / PR

---

### MCP-Builder MCP服务器开发

构建 MCP (Model Context Protocol) 服务器。

### 核心能力
- FastMCP (Python)
- MCP SDK (TypeScript)
- 工具定义与实现

---

### Webapp-Testing E2E测试

使用 Playwright 测试本地的 Web 应用。

### 核心能力
- E2E 自动化测试
- UI 行为验证
- 截图与日志获取

---

### Web-Artifacts-Builder Single-File HTML

使用 React + Tailwind + shadcn/ui 创建复杂的 HTML artifacts。

### 核心能力
- React 18 + TypeScript
- Vite + Parcel 打包
- 40+ shadcn/ui 组件

---

### Slack-GIF-Creator GIF创作

创建 Slack 优化的动画 GIF。

### 核心能力
- 帧动画
- 图形概念与验证
- 尺寸优化

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
