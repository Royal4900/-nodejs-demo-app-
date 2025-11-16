# 🚀 Deployment Instructions for royal4900

## Quick Deploy (Choose One Method)

### Method 1: Using GitHub CLI (Recommended)

**Step 1: Authenticate GitHub CLI**
```powershell
gh auth login
```
When prompted:
- **Protocol:** Choose `HTTPS` (press Enter)
- **Authenticate:** Choose `Login with a web browser` (press Enter)
- **Copy the code** shown and press Enter
- **Browser will open** - paste the code and authorize
- **Grant permissions** to GitHub CLI

**Step 2: Create Repository and Push**
```powershell
powershell -ExecutionPolicy Bypass -File .\deploy-royal4900.ps1
```

OR manually:
```powershell
gh repo create royal4900/nodejs-demo-app --public --source=. --remote=origin --push
```

### Method 2: Manual (Web Interface)

**Step 1: Create Repository on GitHub**
1. Go to: https://github.com/new
2. Repository name: `nodejs-demo-app`
3. Description: "Node.js demo app with CI/CD pipeline"
4. Visibility: **Public** (or Private)
5. **DO NOT** check "Initialize with README"
6. Click **"Create repository"**

**Step 2: Push Your Code**
```powershell
git push -u origin main
```

If prompted for credentials:
- Username: `royal4900`
- Password: Use a **Personal Access Token** (not your GitHub password)
  - Create token at: https://github.com/settings/tokens
  - Scopes needed: `repo` (full control)

## ✅ After Deployment

### Add GitHub Secrets (REQUIRED)

1. Go to: https://github.com/royal4900/nodejs-demo-app/settings/secrets/actions

2. Click **"New repository secret"**

3. Add first secret:
   - Name: `DOCKERHUB_USERNAME`
   - Value: Your DockerHub username
   - Click **"Add secret"**

4. Add second secret:
   - Name: `DOCKERHUB_TOKEN`
   - Value: Your DockerHub access token
     - Get token at: https://hub.docker.com/settings/security
     - Click "New Access Token"
     - Name: `github-actions`
     - Permissions: **Read & Write**
     - Copy the token and paste as secret value
   - Click **"Add secret"**

### Trigger CI/CD Pipeline

```powershell
git commit --allow-empty -m "Trigger CI/CD pipeline"
git push
```

Or make any code change and push.

## 📊 Monitor Your Pipeline

- **Repository:** https://github.com/royal4900/nodejs-demo-app
- **Actions:** https://github.com/royal4900/nodejs-demo-app/actions
- **DockerHub:** https://hub.docker.com/r/royal4900/nodejs-demo-app (after first build)

## ✅ Verification Checklist

- [ ] Repository created on GitHub
- [ ] Code pushed to GitHub
- [ ] GitHub Secrets added (DOCKERHUB_USERNAME, DOCKERHUB_TOKEN)
- [ ] Pipeline triggered (check Actions tab)
- [ ] All 3 jobs pass (Test, Build, Deploy)
- [ ] Docker image appears on DockerHub

## 🆘 Troubleshooting

**"Repository not found" error?**
- Repository doesn't exist yet - create it first (Method 2, Step 1)

**Authentication failed?**
- Use Personal Access Token instead of password
- Or authenticate GitHub CLI first

**Pipeline fails?**
- Check Actions tab for error details
- Verify secrets are correctly named
- Ensure DockerHub token has correct permissions

---

**Ready to deploy!** Follow Method 1 or Method 2 above. 🚀

