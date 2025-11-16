# Deployment script for royal4900 GitHub account
Write-Host "🚀 Deploying to GitHub (royal4900)..." -ForegroundColor Cyan
Write-Host "====================================`n" -ForegroundColor Cyan

# Check if remote is set
$remoteUrl = git remote get-url origin 2>$null
if ($remoteUrl -ne "https://github.com/royal4900/nodejs-demo-app.git") {
    Write-Host "Setting up remote..." -ForegroundColor Yellow
    git remote remove origin 2>$null
    git remote add origin https://github.com/royal4900/nodejs-demo-app.git
    Write-Host "✅ Remote configured" -ForegroundColor Green
} else {
    Write-Host "✅ Remote already configured" -ForegroundColor Green
}

# Check GitHub CLI authentication
Write-Host "`nChecking GitHub CLI authentication..." -ForegroundColor Yellow
$authStatus = gh auth status 2>&1
if ($LASTEXITCODE -ne 0) {
    Write-Host "⚠️  GitHub CLI not authenticated" -ForegroundColor Yellow
    Write-Host "`nPlease authenticate by running:" -ForegroundColor Cyan
    Write-Host "  gh auth login" -ForegroundColor White
    Write-Host "`nThen choose:" -ForegroundColor Gray
    Write-Host "  - Protocol: HTTPS" -ForegroundColor White
    Write-Host "  - Authenticate: Login with a web browser" -ForegroundColor White
    Write-Host "  - Follow the browser prompts" -ForegroundColor White
    Write-Host "`nAfter authentication, run this script again." -ForegroundColor Yellow
    exit 1
} else {
    Write-Host "✅ GitHub CLI authenticated" -ForegroundColor Green
}

# Check if repository exists
Write-Host "`nChecking repository..." -ForegroundColor Yellow
$repoExists = gh repo view royal4900/nodejs-demo-app 2>&1
if ($LASTEXITCODE -ne 0) {
    Write-Host "Creating repository: royal4900/nodejs-demo-app" -ForegroundColor Cyan
    gh repo create royal4900/nodejs-demo-app --public --source=. --remote=origin --push
    
    if ($LASTEXITCODE -eq 0) {
        Write-Host "✅ Repository created and code pushed!" -ForegroundColor Green
    } else {
        Write-Host "❌ Failed to create repository" -ForegroundColor Red
        Write-Host "`nTrying manual push..." -ForegroundColor Yellow
        git push -u origin main
        if ($LASTEXITCODE -eq 0) {
            Write-Host "✅ Code pushed successfully!" -ForegroundColor Green
        } else {
            Write-Host "❌ Push failed. Please check authentication." -ForegroundColor Red
            exit 1
        }
    }
} else {
    Write-Host "✅ Repository already exists" -ForegroundColor Green
    Write-Host "Pushing code..." -ForegroundColor Yellow
    git push -u origin main
    if ($LASTEXITCODE -eq 0) {
        Write-Host "✅ Code pushed successfully!" -ForegroundColor Green
    } else {
        Write-Host "❌ Push failed" -ForegroundColor Red
        exit 1
    }
}

Write-Host "`n✨ Deployment Complete!" -ForegroundColor Green
Write-Host "`n📋 Repository URL: https://github.com/royal4900/nodejs-demo-app" -ForegroundColor Cyan
Write-Host "`n⚠️  IMPORTANT: Add GitHub Secrets" -ForegroundColor Yellow
Write-Host "  Go to: https://github.com/royal4900/nodejs-demo-app/settings/secrets/actions" -ForegroundColor White
Write-Host "`n  Add these secrets:" -ForegroundColor Cyan
Write-Host "    1. DOCKERHUB_USERNAME - Your DockerHub username" -ForegroundColor White
Write-Host "    2. DOCKERHUB_TOKEN - Create at https://hub.docker.com/settings/security" -ForegroundColor White
Write-Host "`n🎯 After adding secrets, trigger the pipeline:" -ForegroundColor Cyan
Write-Host "  git commit --allow-empty -m 'Trigger CI/CD pipeline'" -ForegroundColor White
Write-Host "  git push" -ForegroundColor White

