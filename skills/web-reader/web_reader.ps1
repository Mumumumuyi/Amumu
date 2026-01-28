# web-reader.ps1 - Web Content Reader
# Function: Read webpage content, organize and save to specified folder
# Usage: powershell -ExecutionPolicy Bypass -File web_reader.ps1 "https://example.com"

param(
    [Parameter(Mandatory=$false, Position=0)]
    [string]$Url,

    [Parameter(Mandatory=$false)]
    [ValidateSet('txt', 'md', 'json')]
    [string]$Format = 'md',

    [Parameter(Mandatory=$false)]
    [string]$Output = ''
)

# Get user input
function Get-UserInput {
    param([string]$Prompt, [string]$Default)

    if ($Default) {
        $promptText = "${Prompt} [default: ${Default}]: "
    } else {
        $promptText = "${Prompt}: "
    }
    $input = Read-Host $promptText

    if ([string]::IsNullOrWhiteSpace($input) -and $Default) {
        return $Default
    }
    return $input
}

# Ask save location
function Ask-SaveLocation {
    Write-Host ""
    Write-Host ("=" * 50)
    Write-Host "Please choose save location:"
    Write-Host ("=" * 50)
    Write-Host "1. Current directory"
    Write-Host "2. Desktop"
    Write-Host "3. Documents folder"
    Write-Host "4. Custom path"
    Write-Host ("=" * 50)

    while ($true) {
        $choice = Get-UserInput "Enter option (1-4)"

        switch ($choice) {
            '1' {
                return (Get-Location).Path
            }
            '2' {
                $desktop = [Environment]::GetFolderPath("Desktop")
                if (Test-Path $desktop) { return $desktop }
                return Join-Path $env:USERPROFILE "Desktop"
            }
            '3' {
                $docs = [Environment]::GetFolderPath("MyDocuments")
                if (Test-Path $docs) { return $docs }
                return Join-Path $env:USERPROFILE "Documents"
            }
            '4' {
                $custom = Get-UserInput "Enter save path"
                return $custom
            }
            default {
                Write-Host "Invalid option, please enter (1-4)" -ForegroundColor Yellow
            }
        }
    }
}

# Ask format
function Ask-Format {
    Write-Host ""
    Write-Host "Please choose save format:"
    Write-Host "1. Markdown (.md) - Recommended"
    Write-Host "2. Plain text (.txt)"
    Write-Host "3. JSON (.json) - Structured data"

    while ($true) {
        $choice = Get-UserInput "Enter option (1-3)" "1"

        switch ($choice) {
            '1' { return 'md' }
            '2' { return 'txt' }
            '3' { return 'json' }
            default {
                Write-Host "Invalid option, please enter (1-3)" -ForegroundColor Yellow
            }
        }
    }
}

# Generate filename
function Get-Filename {
    param([string]$Url, [string]$Format)

    $uri = [uri]$Url
    $domain = $uri.Host -replace '^www\.', ''
    $clean = $domain -replace '[^\w\-]', '_'
    $timestamp = Get-Date -Format "yyyyMMdd_HHmmss"

    $ext = switch ($Format) {
        'md' { '.md' }
        'txt' { '.txt' }
        'json' { '.json' }
        default { '.txt' }
    }

    return "${clean}_${timestamp}${ext}"
}

# Fetch web content
function Get-WebContent {
    param([string]$Url)

    try {
        $response = Invoke-WebRequest -Uri $Url -TimeoutSec 30 -UseBasicParsing -ErrorAction Stop

        # Extract title
        $title = ""
        if ($response.ParsedHtml -and $response.ParsedHtml.title) {
            $title = $response.ParsedHtml.title
        } else {
            $match = $response.Content | Select-String '<title>(.*?)</title>' | Select-Object -First 1
            if ($match) {
                $title = $match.Matches.Groups[1].Value
            }
        }

        if ([string]::IsNullOrWhiteSpace($title)) {
            $title = "No title"
        }

        return @{
            Title = $title
            Content = $response.Content
            Url = $response.BaseResponse.ResponseUri.AbsoluteUri
        }
    }
    catch {
        throw "Failed to fetch webpage: $_"
    }
}

# Convert HTML to plain text
function Convert-HtmlToText {
    param([string]$Html)

    # Remove scripts and styles
    $cleanHtml = $Html -replace '<script[^>]*>.*?</script>', '' -replace '<style[^>]*>.*?</style>', '' -replace '<iframe[^>]*>.*?</iframe>', ''
    $cleanHtml = $cleanHtml -replace '<noscript[^>]*>.*?</noscript>', ''

    # Convert tags to newlines
    $cleanHtml = $cleanHtml -replace '<br\s*/?>', "`n" -replace '</p>', "`n`n" -replace '</div>', "`n"
    $cleanHtml = $cleanHtml -replace '</h[1-6]>', "`n" -replace '</li>', "`n"

    # Remove all HTML tags
    $text = $cleanHtml -replace '<[^>]+>', ''

    # Clean up whitespace
    $text = $text -replace '\s+', ' ' -replace "`n\s+", "`n" -replace "`n`n+", "`n`n"

    # Decode HTML entities
    $text = $text -replace '&nbsp;', ' ' -replace '&lt;', '<' -replace '&gt;', '>'
    $text = $text -replace '&amp;', '&' -replace '&quot;', '"' -replace '&#039;', "'"

    return $text.Trim()
}

# Format as Markdown
function Format-Markdown {
    param([hashtable]$Data, [string]$HtmlContent)

    $md = @()
    $timestamp = Get-Date -Format "yyyy-MM-dd HH:mm:ss"

    $md += "# $($Data.Title)"
    $md += ""
    $md += "**URL:** $($Data.Url)"
    $md += "**Collected:** $timestamp"
    $md += ""
    $md += "---"
    $md += ""

    # Extract and add main content
    $mainText = Convert-HtmlToText -HtmlContent $HtmlContent
    if ($mainText.Length -gt 50) {
        # Get first 5000 chars for preview
        if ($mainText.Length -gt 5000) {
            $mainText = $mainText.Substring(0, 5000) + "`n`n...[Content truncated]..."
        }
        $md += "## Main Content"
        $md += ""
        $md += $mainText
        $md += ""
        $md += "---"
        $md += ""
    }

    return $md -join "`n"
}

# Format as plain text
function Format-Text {
    param([hashtable]$Data, [string]$HtmlContent)

    $txt = @()
    $timestamp = Get-Date -Format "yyyy-MM-dd HH:mm:ss"

    $txt += "Title: $($Data.Title)"
    $txt += "URL: $($Data.Url)"
    $txt += "Collected: $timestamp"
    $txt += ("=" * 60)
    $txt += ""

    $mainText = Convert-HtmlToText -HtmlContent $HtmlContent
    if ($mainText.Length -gt 50) {
        if ($mainText.Length -gt 5000) {
            $mainText = $mainText.Substring(0, 5000) + "`n`n...[Content truncated]..."
        }
        $txt += $mainText
    }

    return $txt -join "`n"
}

# Format as JSON
function Format-Json {
    param([hashtable]$Data, [string]$HtmlContent)

    $timestamp = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
    $mainText = Convert-HtmlToText -HtmlContent $HtmlContent

    if ($mainText.Length -gt 5000) {
        $mainText = $mainText.Substring(0, 5000) + "...[Content truncated]..."
    }

    $result = [PSCustomObject]@{
        title = $Data.Title
        url = $Data.Url
        timestamp = $timestamp
        content = $mainText -replace "`n", '\n' -replace "`r", ''
        htmlLength = $HtmlContent.Length
        contentLength = $mainText.Length
    }

    return $result | ConvertTo-Json -Depth 10
}

# Main program
try {
    # Get URL
    if ([string]::IsNullOrWhiteSpace($Url)) {
        $Url = Get-UserInput "Enter webpage URL to read"
    }

    if ([string]::IsNullOrWhiteSpace($Url)) {
        Write-Host "URL cannot be empty!" -ForegroundColor Red
        exit 1
    }

    Write-Host ""
    Write-Host "Reading webpage: $Url" -ForegroundColor Cyan

    # Fetch web content
    $webData = Get-WebContent -Url $Url
    Write-Host "Success: Webpage fetched" -ForegroundColor Green
    Write-Host "  Title: $($webData.Title)" -ForegroundColor Gray

    # Ask save location if not specified
    if ([string]::IsNullOrWhiteSpace($Output)) {
        $saveDir = Ask-SaveLocation
        $format = Ask-Format
    } else {
        $saveDir = $Output
        $format = $Format
    }

    # Format content
    Write-Host "Organizing content..." -ForegroundColor Cyan

    switch ($format) {
        'md' { $content = Format-Markdown -Data $webData -HtmlContent $webData.Content }
        'txt' { $content = Format-Text -Data $webData -HtmlContent $webData.Content }
        'json' { $content = Format-Json -Data $webData -HtmlContent $webData.Content }
    }

    Write-Host "Content organized successfully" -ForegroundColor Green

    # Generate filename
    $filename = Get-Filename -Url $webData.Url -Format $format

    # Save file
    $filepath = Join-Path $saveDir $filename

    # Ensure directory exists
    if (!(Test-Path $saveDir)) {
        New-Item -Path $saveDir -ItemType Directory -Force | Out-Null
    }

    $content | Out-File -FilePath $filepath -Encoding UTF8 -Force

    Write-Host ""
    Write-Host "File saved: $filepath" -ForegroundColor Green
    Write-Host "  Size: $($content.Length) characters" -ForegroundColor Gray
}
catch {
    Write-Host ""
    Write-Host "Error: $_" -ForegroundColor Red
    exit 1
}
