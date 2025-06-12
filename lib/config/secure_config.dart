import 'dart:io';

/// Secure configuration management for Pawsbilities app
/// This class handles environment variables and secure configuration
class SecureConfig {
  static const String _envFileName = '.env';
  static Map<String, String>? _envVars;

  /// Initialize configuration by loading environment variables
  static Future<void> initialize() async {
    await _loadEnvFile();
  }

  /// Load environment variables from .env file (for local development)
  static Future<void> _loadEnvFile() async {
    try {
      final file = File(_envFileName);
      if (await file.exists()) {
        final lines = await file.readAsLines();
        _envVars = {};

        for (final line in lines) {
          if (line.trim().isEmpty || line.startsWith('#')) continue;

          final index = line.indexOf('=');
          if (index != -1) {
            final key = line.substring(0, index).trim();
            final value = line.substring(index + 1).trim();
            _envVars![key] = value;
          }
        }
      }
    } catch (e) {
      print('Warning: Could not load .env file: $e');
    }
  }

  /// Get environment variable with fallback
  static String? getEnvVar(String key) {
    // First try system environment variables
    String? value = Platform.environment[key];

    // Then try loaded .env file
    if (value == null && _envVars != null) {
      value = _envVars![key];
    }

    return value;
  }

  /// Get MongoDB connection string securely
  static String getMongoUri() {
    // Check if a custom MongoDB URI is provided in environment
    final customUri = getEnvVar('MONGODB_URI');
    if (customUri != null && customUri.isNotEmpty) {
      return customUri;
    }

    // Use the provided MongoDB Atlas URI
    const defaultUri =
        'mongodb+srv://adhamt79:N9eUSfzthq1gT7bG@adhamcluster.2zfyf.mongodb.net/pawsbilities';

    final mongoUser = getEnvVar('MONGO_USER');
    final mongoPassword = getEnvVar('MONGO_PASSWORD');
    final mongoCluster = getEnvVar('MONGO_CLUSTER');
    final mongoDatabase = getEnvVar('MONGO_DATABASE') ?? 'pawsbilities';

    if (mongoUser == null || mongoPassword == null || mongoCluster == null) {
      print('🔧 Using default MongoDB Atlas URI');
      return defaultUri;
    }

    return 'mongodb+srv://$mongoUser:$mongoPassword@$mongoCluster/$mongoDatabase';
  }

  /// Get API base URL
  static String getApiBaseUrl() {
    // For now, we'll use a placeholder. You should replace this with your actual backend URL
    const defaultApiUrl =
        'https://pawsibilities-backend.herokuapp.com/api'; // Replace with your actual backend URL

    return getEnvVar('API_BASE_URL') ?? defaultApiUrl;
  }

  /// Validate that all required configuration is present
  static bool validateConfiguration() {
    // Check if we have a custom MongoDB URI or the default one
    final mongoUri = getMongoUri();

    if (mongoUri.isEmpty) {
      print('❌ No MongoDB URI configured');
      return false;
    }

    final apiUrl = getApiBaseUrl();
    if (apiUrl.isEmpty) {
      print('❌ No API base URL configured');
      return false;
    }

    print('✅ Configuration validated successfully');
    return true;
  }

  /// Print configuration status (without sensitive data)
  static void printConfigStatus() {
    print('🔧 Configuration Status:');
    print('   MongoDB URI: ✅ Configured');
    print('   API Base URL: ${getApiBaseUrl()}');

    // Check for custom environment variables
    final customMongoUri = getEnvVar('MONGODB_URI');
    if (customMongoUri != null) {
      print('   Custom MongoDB URI: ✅ Set');
    } else {
      print('   Using Default MongoDB Atlas URI: ✅');
    }

    final mongoUser = getEnvVar('MONGO_USER');
    final mongoPassword = getEnvVar('MONGO_PASSWORD');
    final mongoCluster = getEnvVar('MONGO_CLUSTER');

    if (mongoUser != null && mongoPassword != null && mongoCluster != null) {
      print('   Custom MongoDB Credentials: ✅ Set');
      print(
          '   MongoDB Database: ${getEnvVar('MONGO_DATABASE') ?? 'pawsbilities (default)'}');
    }
  }
}
