# 📋 Manual Deployment Steps for royal4900

## ✅ Pre-Flight Check
- ✅ Git repository initialized
- ✅ Branch: `main`
- ✅ Remote configured: `https://github.com/royal4900/nodejs-demo-app.git`
- ✅ All code committed (5 commits ready)
- ✅ Working tree clean

## 🚀 Step-by-Step Deployment

### Step 1: Create GitHub Repository

1. **Open your browser** and go to:
   ```
   https://github.com/new
   ```

2. **Fill in the form:**
   - **Repository name:** `nodejs-demo-app`
   - **Description:** `Node.js demo app with CI/CD pipeline` (optional)
   - **Visibility:** Choose **Public** or **Private**
   - ⚠️ **IMPORTANT:** Do NOT check "Add a README file"
   - ⚠️ **IMPORTANT:** Do NOT add .gitignore or license

3. **Click:** "Create repository"

### Step 2: Push Your Code

After creating the repository, run this command:

```powershell
git push -u origin main
```

**If prompted for credentials:**
- **Username:** `royal4900`
- **Password:** Use a **Personal Access Token** (NOT your GitHub password)

**To create a Personal Access Token:**
1. Go to: https://github.com/settings/tokens
2. Click: "Generate new token" → "Generate new token (classic)"
3. **Note:** `nodejs-demo-app-deploy`
4. **Expiration:** Choose your preference (90 days recommended)
5. **Select scopes:** Check `repo` (this gives full control of private repositories)
6. Click: "Generate token"
7. **COPY THE TOKEN** (you won't see it again!)
8. Use this token as your password when pushing

### Step 3: Verify Push

After pushing, you should see:
```
Enumerating objects: X, done.
Counting objects: 100% (X/X), done.
...
To https://github.com/royal4900/nodejs-demo-app.git
 * [new branch]      main -> main
Branch 'main' set up to track remote branch 'main' from 'origin'.
```

**Check your repository:**
- Visit: https://github.com/royal4900/nodejs-demo-app
- You should see all your files!

### Step 4: Add GitHub Secrets (REQUIRED for CI/CD)

1. **Go to Secrets page:**
   ```
   https://github.com/royal4900/nodejs-demo-app/settings/secrets/actions
   ```

2. **Add First Secret:**
   - Click: "New repository secret"
   - **Name:** `DOCKERHUB_USERNAME`
   - **Secret:** Your DockerHub username
   - Click: "Add secret"

3. **Add Second Secret:**
   - Click: "New repository secret" again
   - **Name:** `DOCKERHUB_TOKEN`
   - **Secret:** Your DockerHub access token
     - Get token at: https://hub.docker.com/settings/security
     - Click: "New Access Token"
     - **Name:** `github-actions`
     - **Permissions:** Read & Write
     - Click: "Generate"
     - **COPY THE TOKEN** and paste as secret value
   - Click: "Add secret"

### Step 5: Trigger CI/CD Pipeline

Run these commands to trigger the pipeline:

```powershell
git commit --allow-empty -m "Trigger CI/CD pipeline"
git push
```

**OR** make any small change to a file and push.

### Step 6: Monitor Your Pipeline

1. **View Actions:**
   ```
   https://github.com/royal4900/nodejs-demo-app/actions
   ```

2. **Check workflow run:**
   - You should see "CI/CD Pipeline" workflow running
   - Three jobs: Test → Build → Deploy
   - Wait for all to complete (green checkmarks)

3. **Verify Docker image:**
   - After Build job completes, check:
   ```
   https://hub.docker.com/r/royal4900/nodejs-demo-app
   ```

## ✅ Success Checklist

- [ ] Repository created on GitHub
- [ ] Code pushed successfully
- [ ] GitHub Secrets added (DOCKERHUB_USERNAME, DOCKERHUB_TOKEN)
- [ ] Pipeline triggered
- [ ] All 3 jobs passed (Test ✅, Build ✅, Deploy ✅)
- [ ] Docker image visible on DockerHub

## 🎯 Quick Links

- **Repository:** https://github.com/royal4900/nodejs-demo-app
- **Actions:** https://github.com/royal4900/nodejs-demo-app/actions
- **Secrets:** https://github.com/royal4900/nodejs-demo-app/settings/secrets/actions
- **DockerHub:** https://hub.docker.com/r/royal4900/nodejs-demo-app

## 🆘 Troubleshooting

**"Repository not found" error?**
- Make sure you created the repository first (Step 1)

**"Authentication failed" error?**
- Use Personal Access Token, not password
- Make sure token has `repo` scope

**Pipeline fails?**
- Check Actions tab for error details
- Verify secrets are correctly named (case-sensitive!)
- Ensure DockerHub token has Read & Write permissions

---

**Ready? Start with Step 1!** 🚀

