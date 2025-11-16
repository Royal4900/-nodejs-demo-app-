# Node.js Demo App - CI/CD Pipeline

A simple Node.js demo application with automated CI/CD pipeline using GitHub Actions and Docker.

## 📋 Overview

This project demonstrates a complete CI/CD automation process that:
- Runs automated tests
- Builds a Docker image
- Pushes the image to DockerHub
- Triggers on push to main branch

## 🛠️ Tools Used

- **GitHub** - Version control and repository hosting
- **GitHub Actions** - CI/CD automation
- **Node.js** - Runtime environment
- **Docker** - Containerization
- **DockerHub** - Container registry

## 📁 Project Structure

```
.
├── .github/
│   └── workflows/
│       └── main.yml          # GitHub Actions workflow
├── app.js                    # Main application file
├── test.js                   # Test suite
├── package.json              # Node.js dependencies
├── Dockerfile                # Docker image configuration
├── .dockerignore            # Docker ignore file
├── .gitignore               # Git ignore file
└── README.md                # This file
```

## 🚀 Getting Started

### Prerequisites

- Node.js 18+ installed
- Docker installed (for local testing)
- GitHub account
- DockerHub account

### Local Setup

1. **Clone the repository**
   ```bash
   git clone <your-repo-url>
   cd nodejs-demo-app
   ```

2. **Install dependencies**
   ```bash
   npm install
   ```

3. **Run the application**
   ```bash
   npm start
   ```

4. **Run tests**
   ```bash
   npm test
   ```

5. **Access the application**
   - Open http://localhost:3000 in your browser
   - Health check: http://localhost:3000/health
   - API info: http://localhost:3000/api/info

### Docker Setup

1. **Build the Docker image**
   ```bash
   docker build -t nodejs-demo-app .
   ```

2. **Run the container**
   ```bash
   docker run -p 3000:3000 nodejs-demo-app
   ```

## 🔧 CI/CD Pipeline Configuration

### GitHub Actions Workflow

The pipeline is defined in `.github/workflows/main.yml` and includes:

1. **Test Job**
   - Checks out code
   - Sets up Node.js environment
   - Installs dependencies
   - Runs test suite

2. **Build Job**
   - Builds Docker image
   - Pushes to DockerHub
   - Uses Docker Buildx for advanced features

3. **Deploy Job**
   - Runs after successful build
   - Only triggers on main branch
   - Provides deployment notification

### Required GitHub Secrets

To enable DockerHub integration, add these secrets in your GitHub repository settings:

1. Go to **Settings** → **Secrets and variables** → **Actions**
2. Add the following secrets:
   - `DOCKERHUB_USERNAME` - Your DockerHub username
   - `DOCKERHUB_TOKEN` - Your DockerHub access token

### Creating DockerHub Token

1. Log in to DockerHub
2. Go to **Account Settings** → **Security** → **New Access Token**
3. Create a token with read/write permissions
4. Copy the token and add it as `DOCKERHUB_TOKEN` secret in GitHub

## 📝 API Endpoints

- `GET /` - Welcome message with app information
- `GET /health` - Health check endpoint
- `GET /api/info` - Application and environment information

## 🔄 Workflow Triggers

The CI/CD pipeline automatically triggers on:
- Push to `main` branch
- Pull requests to `main` branch

## 📦 Deliverables

✅ GitHub repository with CI/CD workflow  
✅ Automated test → build → push pipeline  
✅ Docker image deployment to DockerHub  
✅ Node.js demo application  

## 🎯 Learning Outcomes

By completing this project, you will understand:
- How to set up GitHub Actions workflows
- Docker image creation and deployment
- CI/CD pipeline automation
- Integration of testing, building, and deployment steps
- Container registry usage (DockerHub)

## 📄 License

ISC

