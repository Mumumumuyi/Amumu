---
name: fullstack-dev
description: 全栈开发专家技能集，集成了所有前后端、设计、测试和工具能力。包含：backend-expert(后端API开发/数据库/认证/容器化)、connect-apps(外部服务集成/Gmail/Slack/GitHub)、frontend-design(高级UI设计)、frontend-expert(React组件/状态管理/测试)、mcp-builder(MCP服务器开发)、slack-gif-creator(Slack动画GIF)、webapp-testing(Playwright测试)、web-artifacts-builder(React+Tailwind+shadcn/ui artifacts)、web-search(网络搜索)、web-reader(网页内容读取)。适用于全栈开发、Web应用构建、API设计、前后端集成、自动化测试等场景。
license: Complete terms in LICENSE
---

# Fullstack Dev - 全栈开发专家技能集

本skill集成了10个专业技能，提供端到端的全栈开发能力。

---

## 技能概览

| 技能 | 领域 | 核心能力 |
|------|------|---------|
| **backend-expert** | 后端开发 | API设计、数据库、认证、容器化、配置管理 |
| **connect-apps** | 服务集成 | Gmail、Slack、GitHub等外部API集成 |
| **frontend-design** | UI设计 | 高级视觉设计、免AI生成审美、创意布局 |
| **frontend-expert** | 前端开发 | React组件、状态管理、构建工具、测试 |
| **mcp-builder** | MCP开发 | Model Context Protocol服务器构建 |
| **slack-gif-creator** | GIF创作 | Slack优化的动画GIF |
| **webapp-testing** | E2E测试 | Playwright自动化测试 |
| **web-artifacts-builder** | Artifacts | React+Tailwind+shadcn/ui单文件HTML |
| **web-search** | 网络搜索 | 浏览器Google搜索 |
| **web-reader** | 内容抓取 | 网页内容解析与提取 |

---

## 1. Backend Expert - 后端开发

### 核心技术栈

| 领域 | 技术选项 |
|------|---------|
| **语言** | Node.js/TypeScript, Python (FastAPI/Flask), Go, Java |
| **API类型** | REST, GraphQL, gRPC |
| **数据库** | MySQL, PostgreSQL, MongoDB, Redis |
| **容器化** | Docker, Kubernetes |
| **认证** | JWT, OAuth2, RBAC |

### API设计最佳实践

```python
# FastAPI 示例
from fastapi import FastAPI, HTTPException, Depends
from fastapi.security import OAuth2PasswordBearer

app = FastAPI(title="My API", version="1.0.0")

oauth2_scheme = OAuth2PasswordBearer(tokenUrl="token")

@app.get("/items/{item_id}")
async def read_item(item_id: int, token: str = Depends(oauth2_scheme)):
    """获取单个项目"""
    item = get_item(item_id)
    if not item:
        raise HTTPException(status_code=404, detail="Item not found")
    return item
```

### 数据库设计原则

- 范式化 vs 反范式化根据查询需求选择
- 适当的索引（外键、常用查询字段）
- 软删除（deleted_at）而非硬删除
- 时间戳（created_at, updated_at）必需

### 认证与授权

| 场景 | 方案 |
|------|------|
| 用户登录 | JWT + Refresh Token |
| 第三方登录 | OAuth2 / OpenID Connect |
| API访问 | API Key (Webhook) |
| 内部服务 | mTLS / Service Token |

### Docker化

```dockerfile
# Dockerfile 示例
FROM node:18-alpine
WORKDIR /app
COPY package*.json ./
RUN npm ci --only=production
COPY . .
EXPOSE 3000
CMD ["node", "src/index.js"]
```

---

## 2. Connect Apps - 服务集成

### 支持的集成

| 服务 | 能力 |
|------|------|
| **Gmail** | 发送/搜索邮件、管理线程 |
| **Slack** | 发送消息、上传文件、管理频道 |
| **GitHub** | 创建Issue、PR、管理评论 |

### Gmail 集成示例

```python
import gspread
from google.oauth2.service_account import Credentials

scopes = ['https://www.googleapis.com/auth/gmail.readonly']
creds = Credentials.from_service_account_file('credentials.json', scopes=scopes)
service = build('gmail', 'v1', credentials=creds)
```

### Slack 集成示例

```python
from slack_sdk import WebClient
from slack_sdk.errors import SlackApiError

client = WebClient(token="xoxb-your-token")
response = client.chat_postMessage(channel="#general", text="Hello!")
```

---

## 3. Frontend Design - UI设计

### 设计思维流程

1. **理解目的**: 这个界面解决什么问题？谁在使用？
2. **确定风格**: 选择一个极致方向（极简主义、复古未来、有机自然等）
3. **识别约束**: 框架、性能、可访问性要求
4. **差异化**: 什么让这个设计令人难忘？

### 审美指南

| 元素 | 建议 |
|------|------|
| **字体** | 避免Inter/Roboto/Arial，选择独特的展示字体 |
| **色彩** | 为主导色配以鲜明点缀色，使用CSS变量 |
| **动效** | 优先CSS动画，集中在高影响力时刻 |
| **布局** | 非对称、重叠、对角流动、打破网格 |
| **背景** | 渐变网格、噪声纹理、几何图案、层叠透明 |

### 避免AI生成审美

❌ 紫色渐变 + 白色背景
❌ 统一的圆角
❌ 过度居中布局
❌ Inter字体
✅ 根据上下文做出有创意的选择

---

## 4. Frontend Expert - 前端开发

### React组件结构

```tsx
interface Props {
  title: string;
  onAction: () => void;
}

export function Component({ title, onAction }: Props) {
  // Hooks first
  const [state, setState] = useState();
  const ref = useRef(null);

  // Event handlers
  const handleClick = () => {
    onAction();
  };

  // Effects (keep minimal)
  useEffect(() => {
    // effect logic
  }, []);

  // Render
  return <div onClick={handleClick}>{title}</div>;
}
```

### 状态管理选择

| 场景 | 方案 |
|------|------|
| 本地UI状态 | `useState`, `useReducer` |
| 表单状态 | React Hook Form + Zod |
| 跨组件 | Context API |
| 服务端状态 | TanStack Query |
| 全局状态 | Zustand, Jotai, Redux Toolkit |

### 测试金字塔

```
         E2E (Playwright) - 少量、慢、高置信度
                /\
               /  \
            Integration (Testing Library)
              /        \
           Unit (Vitest) - 大量、快、聚焦
```

### Vite 配置示例

```ts
import { defineConfig } from 'vite';
import react from '@vitejs/plugin-react';

export default defineConfig({
  plugins: [react()],
  build: {
    target: 'es2020',
    sourcemap: true,
  },
  resolve: {
    alias: {
      '@': '/src',
    },
  },
});
```

---

## 5. MCP Builder - MCP服务器开发

### MCP (Model Context Protocol)

用于让LLM与外部服务交互的协议。

### FastMCP 开发示例

```python
from mcp import FastMCP

mcp = FastMCP("My App")

@mcp.tool()
async def search_books(query: str) -> str:
    """搜索书籍
    Args:
        query: 搜索关键词
    """
    # 实现逻辑
    return f"Found books for: {query}"

if __name__ == "__main__":
    mcp.run()
```

### MCP SDK (TypeScript)

```typescript
import { Server } from "@modelcontextprotocol/sdk/server/index.js";

const server = new Server(
  { name: "my-server", version: "1.0.0" },
  { capabilities: { tools: {} } }
);

server.setRequestHandler(CallToolRequestSchema, async (request) => {
  // 工具处理逻辑
});
```

---

## 6. Slack GIF Creator - 动画GIF创作

### Slack GIF约束

| 约束 | 规格 |
|------|------|
| 最大尺寸 | 10MB |
| 帧率 | 15-30fps |
| 循环 | 必须 |
| 文件大小 | 小于100KB为佳 |

### 图形概念

- 位移动画 (Translation)
- 缩放/脉动 (Scaling/Pulsing)
- 旋转 (Rotation)
- 变形 (Morphing)
- 颜色/透明度变化 (Color/Opacity)
- 合成效果 (Composition)

---

## 7. Webapp Testing - E2E测试

### Playwright 测试示例

```ts
import { test, expect } from '@playwright/test';

test.describe('登录流程', () => {
  test('有效登录', async ({ page }) => {
    await page.goto('/');
    await page.click('text=登录');
    await page.fill('[name="email"]', 'user@example.com');
    await page.fill('[name="password"]', 'password');
    await page.click('button[type="submit"]');
    await expect(page).toHaveURL('/dashboard');
  });
});
```

### 测试最佳实践

- 使用data-testid而非选择器
- 每个测试独立运行
- 使用page object模式
- 测试用户行为而非实现细节

---

## 8. Web Artifacts Builder - 单文件HTML

### 快速流程

```bash
# 1. 初始化项目
bash scripts/init-artifact.sh <project-name>
cd <project-name>

# 2. 开发artifact (编辑代码)

# 3. 打包成单HTML
bash scripts/bundle-artifact.sh

# 4. 生成的 bundle.html 可直接分享
```

### 技术栈

- React 18 + TypeScript
- Vite + Parcel (打包)
- Tailwind CSS 3.4.1
- shadcn/ui (40+组件)

### 避免的设计模式

❌ 过度居中布局
❌ 紫色渐变
❌ 统一圆角
❌ Inter字体

---

## 9. Web Search - 网络搜索

### 使用方式

```bash
# 通过自定义命令
/search 搜索关键词
```

### 功能

- 在默认浏览器中打开Google搜索
- 支持URL编码的查询字符串

---

## 10. Web Reader - 网页内容读取

### 使用方式

```bash
# 通过自定义命令
/read https://example.com
```

### 功能

- 抓取网页原始HTML
- 清理无关内容
- 提取正文文本
- 保存到文件

---

## 开发工作流程

### 完整全栈项目流程

```
1. 需求分析 → Frontend Design (UI设计)
                ↓
2. 前端开发 → Frontend Expert (React组件)
                ↓
3. 后端开发 → Backend Expert (API设计)
                ↓
4. 服务集成 → Connect Apps (第三方API)
                ↓
5. 工具开发 → MCP Builder (服务器扩展)
                ↓
6. 测试验证 → Webapp Testing (E2E测试)
                ↓
7. 文档搜索 → Web Search/Web Reader (资料收集)
```

### 快捷命令参考

| 需求 | 使用 |
|------|------|
| 创建React组件 | Frontend Expert |
| 设计UI界面 | Frontend Design |
| 搭建后端API | Backend Expert |
| 集成GitHub | Connect Apps |
| 测试Web应用 | Webapp Testing |
| 创建Artifact | Web Artifacts Builder |
| 搜索资料 | Web Search |
| 读取网页 | Web Reader |
| 开发MCP服务 | MCP Builder |
| 制作Slack GIF | Slack GIF Creator |

---

## 常见场景

### 场景1: 从零构建Web应用

1. 使用 Frontend Design 设计界面
2. 使用 Frontend Expert 开发React组件
3. 使用 Backend Expert 设计和实现API
4. 使用 Connect Apps 集成第三方服务
5. 使用 Webapp Testing 进行E2E测试

### 场景2: 创建交互式演示

1. 使用 Web Artifacts Builder 初始化项目
2. 开发React组件和逻辑
3. 使用 Web Search/Web Reader 收集数据
4. 打包成单HTML文件分享

### 场景3: 开发MCP服务器

1. 使用 MCP Builder 框架
2. 使用 Backend Expert 处理后端逻辑
3. 使用 Webapp Testing 测试工具调用
