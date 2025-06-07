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
    final mongoUser = getEnvVar('MONGO_USER');
    final mongoPassword = getEnvVar('MONGO_PASSWORD');
    final mongoCluster = getEnvVar('MONGO_CLUSTER');
    final mongoDatabase = getEnvVar('MONGO_DATABASE') ?? 'pawsbilities';

    if (mongoUser == null || mongoPassword == null || mongoCluster == null) {
      print('⚠️ MongoDB credentials not found in environment variables');
      print('📝 Please set MONGO_USER, MONGO_PASSWORD, and MONGO_CLUSTER');
      print('🔄 Falling back to localhost connection');
      return 'mongodb://localhost:27017/$mongoDatabase';
    }

    return 'mongodb+srv://$mongoUser:$mongoPassword@$mongoCluster/$mongoDatabase';
  }

  /// Get API base URL
  static String getApiBaseUrl() {
    return getEnvVar('API_BASE_URL') ?? 'http://localhost:3000/api';
  }

  /// Validate that all required configuration is present
  static bool validateConfiguration() {
    final mongoUser = getEnvVar('MONGO_USER');
    final mongoPassword = getEnvVar('MONGO_PASSWORD');
    final mongoCluster = getEnvVar('MONGO_CLUSTER');

    if (mongoUser == null || mongoPassword == null || mongoCluster == null) {
      print('❌ Missing required MongoDB configuration');
      print('📋 Required environment variables:');
      print('   - MONGO_USER');
      print('   - MONGO_PASSWORD');
      print('   - MONGO_CLUSTER');
      print('   - MONGO_DATABASE (optional, defaults to "pawsbilities")');
      return false;
    }

    return true;
  }

  /// Print configuration status (without sensitive data)
  static void printConfigStatus() {
    print('🔧 Configuration Status:');
    print(
        '   MongoDB User: ${getEnvVar('MONGO_USER') != null ? '✅ Set' : '❌ Missing'}');
    print(
        '   MongoDB Password: ${getEnvVar('MONGO_PASSWORD') != null ? '✅ Set' : '❌ Missing'}');
    print(
        '   MongoDB Cluster: ${getEnvVar('MONGO_CLUSTER') != null ? '✅ Set' : '❌ Missing'}');
    print(
        '   MongoDB Database: ${getEnvVar('MONGO_DATABASE') ?? 'pawsbilities (default)'}');
    print('   API Base URL: ${getApiBaseUrl()}');
  }
}
