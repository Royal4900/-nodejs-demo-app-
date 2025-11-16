# Complete CI/CD Setup Automation Script
# This script automates the entire setup process

param(
    [string]$GitHubUsername = "",
    [string]$DockerHubUsername = ""
)

Write-Host "`n🚀 COMPLETE CI/CD SETUP AUTOMATION" -ForegroundColor Cyan
Write-Host "==================================`n" -ForegroundColor Cyan

# Step 1: Verify Git Setup
Write-Host "[1/6] Verifying Git setup..." -ForegroundColor Yellow
if (-not (Test-Path .git)) {
    Write-Host "  Initializing Git repository..." -ForegroundColor Gray
    git init
    git add .
    git commit -m "Initial commit: Node.js demo app with CI/CD pipeline"
}
Write-Host "  ✅ Git repository ready" -ForegroundColor Green

# Step 2: Ensure we're on main branch
Write-Host "`n[2/6] Setting up branch..." -ForegroundColor Yellow
$currentBranch = git branch --show-current
if ($currentBranch -ne "main") {
    git branch -M main
    Write-Host "  ✅ Switched to main branch" -ForegroundColor Green
} else {
    Write-Host "  ✅ Already on main branch" -ForegroundColor Green
}

# Step 3: Check GitHub CLI
Write-Host "`n[3/6] Checking GitHub CLI..." -ForegroundColor Yellow
try {
    $null = gh --version 2>&1
    Write-Host "  ✅ GitHub CLI installed" -ForegroundColor Green
    
    # Check authentication
    $authCheck = gh auth status 2>&1
    if ($LASTEXITCODE -ne 0) {
        Write-Host "  ⚠️  GitHub CLI not authenticated" -ForegroundColor Yellow
        Write-Host "`n  Please authenticate by running:" -ForegroundColor Cyan
        Write-Host "    gh auth login" -ForegroundColor White
        Write-Host "`n  Then run this script again." -ForegroundColor Gray
        exit 1
    } else {
        Write-Host "  ✅ GitHub CLI authenticated" -ForegroundColor Green
    }
} catch {
    Write-Host "  ❌ GitHub CLI not found" -ForegroundColor Red
    Write-Host "  Install from: https://cli.github.com/" -ForegroundColor Gray
    exit 1
}

# Step 4: Create GitHub Repository
Write-Host "`n[4/6] Creating GitHub repository..." -ForegroundColor Yellow
$remoteUrl = git remote get-url origin 2>$null
if (-not $remoteUrl) {
    $repoName = "nodejs-demo-app"
    Write-Host "  Creating repository: $repoName" -ForegroundColor Gray
    
    gh repo create $repoName --public --source=. --remote=origin --push 2>&1 | Out-Null
    
    if ($LASTEXITCODE -eq 0) {
        Write-Host "  ✅ Repository created and code pushed!" -ForegroundColor Green
        $repoUrl = gh repo view --web 2>&1 | Select-String -Pattern "https://github.com" | ForEach-Object { $_.ToString() }
    } else {
        Write-Host "  ❌ Failed to create repository" -ForegroundColor Red
        Write-Host "  Please create manually at: https://github.com/new" -ForegroundColor Gray
        exit 1
    }
} else {
    Write-Host "  ✅ Remote already configured: $remoteUrl" -ForegroundColor Green
    Write-Host "  Pushing code..." -ForegroundColor Gray
    git push -u origin main
    if ($LASTEXITCODE -eq 0) {
        Write-Host "  ✅ Code pushed successfully!" -ForegroundColor Green
    }
}

# Step 5: Get repository URL
Write-Host "`n[5/6] Getting repository information..." -ForegroundColor Yellow
$repoInfo = gh repo view --json nameWithOwner,url 2>&1
if ($LASTEXITCODE -eq 0) {
    $repoData = $repoInfo | ConvertFrom-Json
    $repoUrl = $repoData.url
    $repoFullName = $repoData.nameWithOwner
    Write-Host "  ✅ Repository: $repoFullName" -ForegroundColor Green
    Write-Host "  📍 URL: $repoUrl" -ForegroundColor Cyan
} else {
    Write-Host "  ⚠️  Could not get repo info" -ForegroundColor Yellow
    $repoUrl = "https://github.com/YOUR_USERNAME/nodejs-demo-app"
    $repoFullName = "YOUR_USERNAME/nodejs-demo-app"
}

# Step 6: Instructions for Secrets
Write-Host "`n[6/6] Final setup instructions..." -ForegroundColor Yellow
Write-Host "`n📋 REQUIRED: Add GitHub Secrets" -ForegroundColor Cyan
Write-Host "  Go to: $repoUrl/settings/secrets/actions" -ForegroundColor White
Write-Host "`n  Add these secrets:" -ForegroundColor Yellow
Write-Host "    1. DOCKERHUB_USERNAME" -ForegroundColor White
Write-Host "       Value: Your DockerHub username" -ForegroundColor Gray
Write-Host "`n    2. DOCKERHUB_TOKEN" -ForegroundColor White
Write-Host "       Value: Create at https://hub.docker.com/settings/security" -ForegroundColor Gray
Write-Host "       Permissions: Read & Write" -ForegroundColor Gray

Write-Host "`n✨ Setup Complete!" -ForegroundColor Green
Write-Host "`n🎯 Next Steps:" -ForegroundColor Cyan
Write-Host "  1. Add GitHub Secrets (see above)" -ForegroundColor White
Write-Host "  2. View Actions: $repoUrl/actions" -ForegroundColor White
Write-Host "  3. Push any change to trigger pipeline" -ForegroundColor White
Write-Host "  4. Monitor workflow execution" -ForegroundColor White

Write-Host "`n💡 To trigger pipeline now, run:" -ForegroundColor Yellow
Write-Host "  git commit --allow-empty -m 'Trigger CI/CD pipeline'" -ForegroundColor White
Write-Host "  git push" -ForegroundColor White

