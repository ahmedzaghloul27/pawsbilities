# 🔐 Security Setup Guide for Pawsbilities

## ⚠️ IMPORTANT: Database Credentials Security

This project uses MongoDB Atlas with sensitive credentials that must **NEVER** be committed to git.

## 🚀 Quick Setup

### 1. Change MongoDB Password
1. Go to [MongoDB Atlas Dashboard](https://cloud.mongodb.com/)
2. Navigate to **Database Access**
3. Find user `adhamt79` and click **Edit**
4. **Generate a new password** (the old one was exposed)
5. Save the new password securely

### 2. Create Environment File
1. Copy `env_example.txt` to `.env` in the project root
2. Fill in your actual MongoDB credentials:

```bash
# .env file (DO NOT COMMIT THIS FILE)
MONGO_USER=adhamt79
MONGO_PASSWORD=your_new_secure_password_here
MONGO_CLUSTER=adhamcluster.2zfyf.mongodb.net
MONGO_DATABASE=pawsbilities
API_BASE_URL=http://localhost:3000/api
```

### 3. Verify Setup
Run the app and check the console for configuration status:
```
🔧 Configuration Status:
   MongoDB User: ✅ Set
   MongoDB Password: ✅ Set
   MongoDB Cluster: ✅ Set
   MongoDB Database: pawsbilities
   API Base URL: http://localhost:3000/api
```

## 🛡️ Security Best Practices

### ✅ DO:
- Use environment variables for all sensitive data
- Keep `.env` file in `.gitignore`
- Use different credentials for development and production
- Rotate passwords regularly
- Review commits before pushing

### ❌ DON'T:
- Hardcode credentials in source code
- Commit `.env` files to git
- Share credentials in chat/email
- Use the same password for multiple environments

## 🚨 If Credentials Are Exposed:
1. **Change passwords immediately**
2. **Rotate API keys**
3. **Review access logs**
4. **Update all affected systems**

## 🔧 Development Setup

### Using IDE Environment Variables:
Most IDEs allow setting environment variables:

**VS Code:**
```json
// .vscode/launch.json
{
  "configurations": [{
    "name": "Flutter",
    "request": "launch",
    "type": "dart",
    "env": {
      "MONGO_USER": "your_username",
      "MONGO_PASSWORD": "your_password",
      "MONGO_CLUSTER": "adhamcluster.2zfyf.mongodb.net"
    }
  }]
}
```

**Android Studio:**
- Run > Edit Configurations
- Add environment variables in the "Environment variables" field

### Using Terminal:
```bash
export MONGO_USER=your_username
export MONGO_PASSWORD=your_password
export MONGO_CLUSTER=adhamcluster.2zfyf.mongodb.net
flutter run
```

## 🏗️ Production Deployment

For production deployments:
- Use proper secrets management (AWS Secrets Manager, Azure Key Vault, etc.)
- Set environment variables in your hosting platform
- Never deploy with `.env` files
- Use different database users for production

## 📞 Need Help?

If you encounter issues:
1. Check that `.env` file exists and has correct values
2. Verify MongoDB Atlas user permissions
3. Check console output for configuration status
4. Ensure `.env` is in `.gitignore`

Remember: **Security is everyone's responsibility!** 🛡️ 