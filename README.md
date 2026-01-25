# Amumu

## Skills

### 前端专家 (Frontend Expert)

专门为 Claude Code 设计的前端开发技能，专注于 React 生态系统。

| 类别 | 功能 |
|------|------|
| **React 组件开发** | 组件结构模式、最佳实践、复合组件、自定义 Hooks |
| **状态管理** | useState、useReducer、Context API、TanStack Query、Zustand |
| **构建工具** | Vite 配置、Webpack 配置参考 |
| **测试方案** | Vitest (单元测试)、Playwright (E2E 测试)、React Testing Library |
| **样式方案** | Tailwind CSS、shadcn/ui、styled-components、CSS Modules |
| **性能优化** | 代码分割、懒加载、React Profiler 分析 |

**安装方法：**

1. 下载 `skills/frontend-expert.skill` 文件
2. 解压到 Claude Code 的技能目录：
   ```
   Windows: C:\Users\<用户名>\.claude\skills\
   Linux/Mac: ~/.claude/skills/
   ```
3. 重启 Claude Code，技能会自动加载

**使用示例：**
```
"帮我创建一个 React 组件"
"配置 Vite + React + TypeScript 项目"
"如何使用 TanStack Query 处理 API 请求？"
"帮我写一个 Playwright 测试"
"优化 React 组件性能"
```

**技术栈：** React 18+ / TypeScript / Vite / Tailwind CSS / Vitest / Playwright

---

### 后端专家 (Backend Expert)

全栈后端开发技能，精通多种后端语言和框架，并提供完整的前后端协作能力。

| 类别 | 支持 |
|------|--------|
| **后端语言** | Node.js/TypeScript, Python, Go, Java |
| **主流框架** | NestJS, FastAPI, Django, Spring Boot |
| **API 开发** | RESTful, GraphQL, gRPC |
| **数据库** | PostgreSQL, MySQL, MongoDB, Redis |
| **认证授权** | JWT, OAuth2, RBAC |
| **容器化部署** | Docker, Kubernetes |
| **前后端协作** | Monorepo, 共享类型, API 文档, 请求/响应 |

**技能结构：**
```
backend-expert/
├── SKILL.md                    # 主技能文件
├── references/                 # 参考文档
│   ├── API_PATTERNS.md      # API 设计模式
│   ├── AUTH.md               # 认证授权实现
│   ├── DATABASE.md            # 数据库操作与优化
│   ├── DEPLOYMENT.md         # Docker/K8s 部署
│   ├── MONOREPO.md          # Monorepo 结构
│   └── TESTING.md            # 单元/集成测试
└── assets/nestjs-template/   # NestJS 项目模板
    ├── package.json
    ├── Dockerfile
    ├── docker-compose.yml
    ├── prisma/schema.prisma
    └── src/
        ├── main.ts
        ├── app.module.ts
        ├── modules/user/        # CRUD 示例
        └── common/
            ├── guards/         # JWT/Roles 守卫
            ├── decorators/      # 自定义装饰器
            └── prisma/         # Prisma 服务
```

**使用示例：**
```
"创建一个 NestJS 后端 API"
"设计用户认证系统（JWT + RBAC）"
"配置 PostgreSQL + Prisma"
"使用 Docker 部署应用"
"搭建 Monorepo 前后端项目"
```

**技术栈：** NestJS / Prisma / PostgreSQL / Redis / Docker / Kubernetes

---

## 快速开始

### 全栈项目模板

使用内置的模板快速搭建前后端分离项目：

```bash
# 前端 - React + Vite
cp assets/react-vite-template/* my-web/
cd my-web && npm install && npm run dev

# 后端 - NestJS + Prisma
cp assets/nestjs-template/* my-api/
cd my-api && npm install && npm run dev

# 使用 Docker Compose 同时启动
docker-compose up
```

## 仓库结构

```
Amumu/
├── skills/
│   ├── frontend-expert.skill    # 前端专家技能 (17KB)
│   └── backend-expert.skill     # 后端专家技能 (27KB)
```
