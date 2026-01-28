# Web-Search 网络搜索工具

在本地默认浏览器中快速打开 Google 搜索的命令行工具。

## 文件说明

| 文件 | 平台 | 说明 |
|------|------|------|
| `web_search.py` | 跨平台 | Python 版本，支持 Windows/macOS/Linux |
| `web_search.ps1` | Windows | PowerShell 版本 |
| `web_search.bat` | Windows | 批处理版本（简单） |
| `web_search.sh` | Linux/macOS | Bash 脚本版本 |

## 使用方法

### Windows (推荐 PowerShell)
```powershell
powershell -ExecutionPolicy Bypass -File web_search.ps1 "搜索关键词"

# 示例
powershell -ExecutionPolicy Bypass -File web_search.ps1 Claude Code skills
```

### Windows (批处理)
```cmd
web_search.bat "搜索关键词"
```

### Python (跨平台)
```bash
python web_search.py "搜索关键词"
```

### Linux/macOS
```bash
./web_search.sh "搜索关键词"
```

## 配置为 Claude Code 斜杠命令

要在 Claude Code 中使用 `/search` 命令，需要按系统配置文件：

### 步骤 1: 添加脚本到 PATH

**Windows (PowerShell):**
```powershell
# 添加脚本路径到环境变量
$env:Path += ";C:\Users\amumu"

# 或者复制到系统 PATH 目录（如已配置）
copy web_search.ps1 "C:\Users\amumu\AppData\Local\Microsoft\WindowsApps"
```

**Linux/macOS:**
```bash
chmod +x web_search.sh
mv web_search.sh ~/bin/search  # ~/bin 需要在 PATH 中
```

### 步骤 2: 添加到 Claude Code 配置

Claude Code 的配置文件位置因系统而异，通常是：

- **Windows:** `%APPDATA%\Claude\config.json` 或 `.claude/config.json`
- **Linux/macOS:** `~/.config/claude/config.json` 或 `~/.claude/config.json`

在配置文件中添加斜杠命令：

```json
{
  "slashCommands": {
    "search": {
      "description": "在浏览器中搜索",
      "command": "powershell -ExecutionPolicy Bypass -File \"C:/Users/amumu/web_search.ps1\""
    }
  }
}
```

### 步骤 3: 使用

在 Claude Code 中直接输入：
```
/search 你的搜索关键词
```

## 简化 PowerShell 别名 (Windows)

在 PowerShell 配置文件 `$PROFILE` 中添加别名：

```powershell
# 编辑配置文件
notepad $PROFILE

# 添加以下内容
function Search {
    param([Parameter(ValueFromRemainingArguments)][string[]]$Keywords)
    $query = $Keywords -join " "
    Start-Process "https://www.google.com/search?q=$( [uri]::EscapeDataString($query) )"
}
Set-Alias -Name g -Value Search
```

然后就可以用 `g 搜索词` 快速搜索了！
