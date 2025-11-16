# 🚀 Quick Start Guide - Complete Setup

## Automated Setup (Recommended)

### Option 1: Using GitHub CLI (Fastest)

1. **Run the deployment script:**
   ```powershell
   .\deploy-to-github.ps1
   ```
   This will:
   - Check GitHub CLI authentication
   - Create the GitHub repository
   - Push your code
   - Guide you through adding secrets

2. **Add GitHub Secrets:**
   - Go to: `https://github.com/YOUR_USERNAME/nodejs-demo-app/settings/secrets/actions`
   - Add `DOCKERHUB_USERNAME` (your DockerHub username)
   - Add `DOCKERHUB_TOKEN` (create at https://hub.docker.com/settings/security)

3. **Trigger the pipeline:**
   - Make any change and push to main, OR
   - Go to Actions tab and manually trigger the workflow

### Option 2: Manual Setup

1. **Create GitHub Repository:**
   - Go to https://github.com/new
   - Name: `nodejs-demo-app`
   - Visibility: Public or Private
   - **Don't** initialize with README

2. **Connect and Push:**
   ```powershell
   git remote add origin https://github.com/YOUR_USERNAME/nodejs-demo-app.git
   git branch -M main
   git push -u origin main
   ```

3. **Add GitHub Secrets:**
   - Repository → Settings → Secrets and variables → Actions
   - Add `DOCKERHUB_USERNAME`
   - Add `DOCKERHUB_TOKEN`

4. **Get DockerHub Token:**
   - Go to https://hub.docker.com/settings/security
   - Click "New Access Token"
   - Name: `github-actions`
   - Permissions: Read & Write
   - Copy the token

## ✅ Verification

After setup, check:
- ✅ Code is on GitHub
- ✅ Secrets are added
- ✅ Push to main triggers workflow
- ✅ Actions tab shows running pipeline
- ✅ Docker image appears on DockerHub

## 🎯 What Happens Next?

When you push to `main`:
1. **Test Job** runs → Installs deps, runs tests
2. **Build Job** runs → Builds Docker image, pushes to DockerHub
3. **Deploy Job** runs → Deployment notification

## 📊 Monitor Your Pipeline

- View runs: `https://github.com/YOUR_USERNAME/nodejs-demo-app/actions`
- View Docker image: `https://hub.docker.com/r/YOUR_USERNAME/nodejs-demo-app`

## 🆘 Troubleshooting

**Pipeline fails?**
- Check Actions tab for error details
- Verify secrets are correctly named
- Ensure DockerHub token has correct permissions

**Need help?**
- Check README.md for detailed documentation
- Review `.github/workflows/main.yml` for pipeline config

