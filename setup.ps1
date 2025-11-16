# PowerShell script to complete CI/CD setup
Write-Host "🚀 Node.js Demo App - Complete Setup Script" -ForegroundColor Cyan
Write-Host "==========================================`n" -ForegroundColor Cyan

# Check if git is initialized
if (-not (Test-Path .git)) {
    Write-Host "❌ Git not initialized. Run: git init" -ForegroundColor Red
    exit 1
}

# Check current branch
$currentBranch = git branch --show-current
Write-Host "📍 Current branch: $currentBranch" -ForegroundColor Yellow

# Check if GitHub remote exists
$remoteExists = git remote get-url origin 2>$null
if ($remoteExists) {
    Write-Host "✅ GitHub remote already configured: $remoteExists" -ForegroundColor Green
} else {
    Write-Host "⚠️  GitHub remote not configured" -ForegroundColor Yellow
    Write-Host "`nTo set up GitHub remote, run:" -ForegroundColor Cyan
    Write-Host "  git remote add origin https://github.com/YOUR_USERNAME/nodejs-demo-app.git" -ForegroundColor White
    Write-Host "  git branch -M main" -ForegroundColor White
    Write-Host "  git push -u origin main" -ForegroundColor White
}

# Check for GitHub secrets requirement
Write-Host "`n📋 Required GitHub Secrets:" -ForegroundColor Cyan
Write-Host "  1. DOCKERHUB_USERNAME - Your DockerHub username" -ForegroundColor White
Write-Host "  2. DOCKERHUB_TOKEN - Your DockerHub access token" -ForegroundColor White
Write-Host "`n  Add these at: https://github.com/YOUR_USERNAME/nodejs-demo-app/settings/secrets/actions" -ForegroundColor Gray

# Check if files exist
Write-Host "`n📁 Project Files Check:" -ForegroundColor Cyan
$files = @(".github/workflows/main.yml", "app.js", "package.json", "Dockerfile", "test.js")
foreach ($file in $files) {
    if (Test-Path $file) {
        Write-Host "  ✅ $file" -ForegroundColor Green
    } else {
        Write-Host "  ❌ $file - MISSING" -ForegroundColor Red
    }
}

Write-Host "`n✨ Setup checklist complete!" -ForegroundColor Green
Write-Host "`nNext steps:" -ForegroundColor Cyan
Write-Host "  1. Create GitHub repository (if not done)" -ForegroundColor White
Write-Host "  2. Push code to GitHub" -ForegroundColor White
Write-Host "  3. Add GitHub Secrets (DOCKERHUB_USERNAME and DOCKERHUB_TOKEN)" -ForegroundColor White
Write-Host "  4. Push to main branch to trigger CI/CD pipeline" -ForegroundColor White

