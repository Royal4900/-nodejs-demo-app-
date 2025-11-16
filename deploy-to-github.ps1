# PowerShell script to deploy to GitHub
Write-Host "🚀 Deploying to GitHub..." -ForegroundColor Cyan

# Check if GitHub CLI is available
try {
    $ghVersion = gh --version 2>&1
    Write-Host "✅ GitHub CLI detected" -ForegroundColor Green
} catch {
    Write-Host "❌ GitHub CLI not found. Install from: https://cli.github.com/" -ForegroundColor Red
    exit 1
}

# Check authentication
Write-Host "`n🔐 Checking GitHub authentication..." -ForegroundColor Yellow
$authStatus = gh auth status 2>&1
if ($LASTEXITCODE -ne 0) {
    Write-Host "⚠️  Not authenticated. Running: gh auth login" -ForegroundColor Yellow
    gh auth login
} else {
    Write-Host "✅ Authenticated with GitHub" -ForegroundColor Green
}

# Check if remote exists
$remoteUrl = git remote get-url origin 2>$null
if (-not $remoteUrl) {
    Write-Host "`n📦 Creating GitHub repository..." -ForegroundColor Yellow
    
    # Try to create repo using GitHub CLI
    $repoName = "nodejs-demo-app"
    Write-Host "Creating repository: $repoName" -ForegroundColor Cyan
    
    gh repo create $repoName --public --source=. --remote=origin --push
    
    if ($LASTEXITCODE -eq 0) {
        Write-Host "✅ Repository created and code pushed!" -ForegroundColor Green
    } else {
        Write-Host "❌ Failed to create repository automatically" -ForegroundColor Red
        Write-Host "`nManual steps:" -ForegroundColor Yellow
        Write-Host "  1. Create repo at: https://github.com/new" -ForegroundColor White
        Write-Host "  2. Run: git remote add origin https://github.com/YOUR_USERNAME/nodejs-demo-app.git" -ForegroundColor White
        Write-Host "  3. Run: git push -u origin main" -ForegroundColor White
        exit 1
    }
} else {
    Write-Host "`n📤 Pushing to existing repository..." -ForegroundColor Yellow
    git push -u origin main
    if ($LASTEXITCODE -eq 0) {
        Write-Host "✅ Code pushed successfully!" -ForegroundColor Green
    } else {
        Write-Host "❌ Push failed" -ForegroundColor Red
        exit 1
    }
}

Write-Host "`n✨ Deployment complete!" -ForegroundColor Green
Write-Host "`n⚠️  Don't forget to add GitHub Secrets:" -ForegroundColor Yellow
Write-Host "  - DOCKERHUB_USERNAME" -ForegroundColor White
Write-Host "  - DOCKERHUB_TOKEN" -ForegroundColor White
Write-Host "`n  Add at: https://github.com/YOUR_USERNAME/nodejs-demo-app/settings/secrets/actions" -ForegroundColor Gray

