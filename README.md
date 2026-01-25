# Amumu

## Skills

### Frontend Expert

专门为 Claude Code 设计的前端开发技能，专注于 React 生态系统。

#### 功能特性

| 类别 | 功能 |
|------|------|
| **React 组件开发** | 组件结构模式、最佳实践、复合组件、自定义 Hooks |
| **状态管理** | useState、useReducer、Context API、TanStack Query、Zustand |
| **构建工具** | Vite 配置、Webpack 配置参考 |
| **测试方案** | Vitest (单元测试)、Playwright (E2E 测试)、React Testing Library |
| **样式方案** | Tailwind CSS、shadcn/ui、styled-components、CSS Modules |
| **性能优化** | 代码分割、懒加载、React Profiler 分析 |

#### 安装方法

1. 下载 `skills/frontend-expert.skill` 文件
2. 解压到 Claude Code 的技能目录：
   ```
   Windows: C:\Users\<用户名>\.claude\skills\
   Linux/Mac: ~/.claude/skills/
   ```
3. 重启 Claude Code，技能会自动加载

#### 使用示例

```
"帮我创建一个 React 组件"
"配置 Vite + React + TypeScript 项目"
"如何使用 TanStack Query 处理 API 请求？"
"帮我写一个 Playwright 测试"
"优化 React 组件性能"
```

#### 技能结构

```
frontend-expert/
├── SKILL.md                          # 主技能文件
├── references/                       # 参考文档
│   ├── TESTING.md                    # 测试指南
│   ├── WEBPACK.md                    # Webpack 配置
│   ├── REACT_PATTERNS.md             # React 模式
│   └── TANSTACK_QUERY.md             # TanStack Query
└── assets/react-vite-template/       # React + Vite 项目模板
    ├── package.json
    ├── vite.config.ts
    ├── tailwind.config.ts
    ├── tsconfig.json
    └── src/
        ├── components/               # Button, Card, Input
        ├── hooks/                    # useToggle, useDebounce
        └── lib/utils.ts
```

#### 快速开始

使用内置的 React + Vite 模板快速创建项目：

```bash
# 复制模板到新项目
cp -r assets/react-vite-template/* my-project/
cd my-project
npm install
npm run dev
```

#### 技术栈

- **框架**: React 18+ with TypeScript
- **构建工具**: Vite (推荐) / Webpack
- **路由**: React Router DOM
- **状态管理**: TanStack Query、Zustand
- **样式**: Tailwind CSS
- **测试**: Vitest、Playwright
