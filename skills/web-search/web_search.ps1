# web-search.ps1 - 在默认浏览器中打开 Google 搜索
# 用法: powershell -ExecutionPolicy Bypass -File web-search.ps1 "搜索关键词"

param(
    [Parameter(ValueFromRemainingArguments)]
    [string[]]$Keywords
)

if ($Keywords.Count -eq 0) {
    $QUERY = Read-Host "请输入搜索关键词"
    if ([string]::IsNullOrWhiteSpace($QUERY)) {
        Write-Host "未输入搜索关键词!" -ForegroundColor Red
        exit 1
    }
} else {
    $QUERY = $Keywords -join " "
}

# URL 编码 (使用 .NET 内置方法)
$ENCODED = [uri]::EscapeDataString($QUERY).Replace('+', '%20').Replace('%20', '+')
$URL = "https://www.google.com/search?q=$ENCODED"

Write-Host "正在搜索: $QUERY" -ForegroundColor Cyan
Start-Process $URL
Write-Host "✓ 浏览器已打开" -ForegroundColor Green
