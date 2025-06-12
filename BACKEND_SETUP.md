# Pawsibilities Backend Integration Setup

This document provides instructions for connecting your Flutter app to the Node.js/MongoDB backend.

## 🚀 Backend Deployment

### Step 1: Deploy the Backend

1. **Clone the backend repository:**
   ```bash
   git clone https://github.com/janasoliman61/Pawsibilities-db.git
   cd Pawsibilities-db
   git checkout Final_Merging
   ```

2. **Choose a deployment platform:**
   - **Render** (Recommended): https://render.com
   - **Heroku**: https://heroku.com
   - **Railway**: https://railway.app
   - **Vercel**: https://vercel.com

3. **Deploy the backend:**
   - Connect your GitHub repository to the platform
   - Set the build command: `npm install`
   - Set the start command: `npm start` or `node server.js`
   - Configure environment variables (see below)

### Step 2: Configure Environment Variables

In your deployment platform, set these environment variables:

```
MONGODB_URI=mongodb+srv://adhamt79:N9eUSfzthq1gT7bG@adhamcluster.2zfyf.mongodb.net/pawsbilities
JWT_SECRET=your-jwt-secret-key
NODE_ENV=production
PORT=3000
```

### Step 3: Update Flutter App

1. **Update the API Base URL:**
   Open `lib/services/api_service.dart` and replace:
   ```dart
   static const String baseUrl = 'https://pawsibilities-backend-app.onrender.com/api';
   ```
   With your actual deployed backend URL:
   ```dart
   static const String baseUrl = 'https://your-app-name.onrender.com/api';
   ```

2. **For local development:**
   If running the backend locally, change to:
   ```dart
   static const String baseUrl = 'http://localhost:3000/api';
   ```

## 📱 Flutter App Features Integrated

### ✅ Completed Integrations

1. **Authentication System**
   - User registration and login
   - JWT token management
   - Persistent login sessions
   - Automatic logout on token expiry

2. **User Profile Management**
   - Dynamic user data from backend
   - Profile editing with API sync
   - User location and bio management

3. **Pet Management**
   - Add/remove pets via API
   - Dynamic pet loading
   - Pet data synchronization

4. **Matching Screen**
   - Real-time pet data from database
   - User-specific pet selection
   - Dynamic content based on authentication

5. **State Management**
   - Provider pattern for state management
   - AuthManager for authentication state
   - PetProvider for pet data management

### 🔄 Removed Hardcoded Data

- ❌ Hardcoded user name "Ahmed"
- ❌ Hardcoded user profile data
- ❌ Hardcoded pet lists
- ❌ Static asset images for user profiles
- ❌ Mock pet data in matching screen

### ✅ Added Dynamic Data

- ✅ Real user authentication
- ✅ Dynamic user profiles from database
- ✅ Real pet data from API
- ✅ Network image loading for profiles/pets
- ✅ Error handling and loading states
- ✅ API integration for all CRUD operations

## 🛠 Backend API Endpoints Expected

The Flutter app expects these endpoints to be available:

### Authentication
- `POST /api/auth/register` - User registration
- `POST /api/auth/login` - User login

### Users
- `GET /api/users/profile` - Get user profile
- `PUT /api/users/profile` - Update user profile

### Pets
- `GET /api/pets/user` - Get user's pets
- `GET /api/pets/available` - Get available pets for matching
- `POST /api/pets` - Create new pet
- `DELETE /api/pets/:id` - Delete pet

### Matches
- `GET /api/matches` - Get user matches
- `POST /api/matches` - Create new match

### Posts (Community)
- `GET /api/posts` - Get community posts
- `POST /api/posts` - Create new post

### Lost & Found
- `GET /api/lost-found` - Get lost/found posts
- `POST /api/lost-found` - Create lost/found post

### File Upload
- `POST /api/upload` - Upload images

## 🔧 Local Development Setup

1. **Backend Setup:**
   ```bash
   cd path/to/Pawsibilities-db
   npm install
   npm start
   ```

2. **Flutter Setup:**
   ```bash
   cd path/to/pawsbilities
   flutter pub get
   flutter run
   ```

3. **Update API URL for local development:**
   In `lib/services/api_service.dart`, use:
   ```dart
   static const String baseUrl = 'http://localhost:3000/api';
   ```

## 🗄️ Database Configuration

The app is configured to use your MongoDB Atlas URI:
```
mongodb+srv://adhamt79:N9eUSfzthq1gT7bG@adhamcluster.2zfyf.mongodb.net/pawsbilities
```

This is already set up in `lib/config/secure_config.dart`.

## 🚨 Important Notes

1. **Security**: The MongoDB credentials are currently hardcoded. For production, use environment variables.

2. **Image Handling**: The app supports both network images (from backend) and local assets. Ensure your backend handles image uploads properly.

3. **Error Handling**: The app includes comprehensive error handling for network issues and API failures.

4. **Authentication**: Sessions are persisted using SharedPreferences, so users stay logged in between app restarts.

5. **Chat System**: As requested, chat functionality is minimal - another team member should handle this.

## 🔍 Testing the Integration

1. **Registration**: Test creating a new account
2. **Login**: Test logging in with credentials
3. **Profile**: Test editing profile information
4. **Pets**: Test adding/removing pets
5. **Matching**: Test pet matching functionality

## 📞 Support

If you encounter issues:
1. Check the console logs for error messages
2. Verify your backend is deployed and accessible
3. Ensure the API endpoints match the expected format
4. Check network connectivity

The Flutter app will show loading indicators and error messages to help with debugging. 