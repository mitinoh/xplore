import 'dart:developer' as developer;

class Logger {
  static void logInfo(String msg) {
    developer.log('\x1B[34m$msg\x1B[0m');
  }

  static void logSuccess(String msg) {
    developer.log('\x1B[32m$msg\x1B[0m');
  }

  static void logWarning(String msg) {
    developer.log('\x1B[33m$msg\x1B[0m');
  }

  static void logError(String msg) {
    developer.log('\x1B[31m$msg\x1B[0m');
  }
}
