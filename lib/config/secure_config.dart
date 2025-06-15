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
        _envVars = <String, String>{};
        for (final line in lines) {
          if (line.trim().isEmpty || line.startsWith('#')) continue;
          final idx = line.indexOf('=');
          if (idx != -1) {
            final key = line.substring(0, idx).trim();
            final val = line.substring(idx + 1).trim();
            _envVars![key] = val;
          }
        }
      }
    } catch (e) {
      print('Error loading .env: $e');
    }
  }

  /// Get environment variable (system first, then .env)
  static String? getEnvVar(String key) {
    return Platform.environment[key] ?? _envVars?[key];
  }

  /// Get API base URL
  static String getApiBaseUrl() {
    // Use 10.0.2.2 for Android emulator to access host machine's localhost:5001
    const defaultUrl = 'http://10.0.2.2:5001';
    final envUrl = getEnvVar('API_BASE_URL');

    final finalUrl = envUrl != null && envUrl.isNotEmpty ? envUrl : defaultUrl;

    return finalUrl;
  }

  /// Debug print
  static void printConfigStatus() {
    print('🔧 Configuration Status:');
    print('🔧 API Base URL → ${getApiBaseUrl()}');
    print('🔧 .env variables loaded: ${_envVars?.length ?? 0}');
  }
}
