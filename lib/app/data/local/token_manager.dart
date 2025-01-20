import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TokenRefreshService {
  static final TokenRefreshService _instance = TokenRefreshService._internal();

  factory TokenRefreshService() => _instance;

  TokenRefreshService._internal();

  Timer? _refreshTimer;
  static const int TOKEN_EXPIRATION = 7 * 24 * 60 * 60 * 1000; // 24 hours
  static const String TOKEN_TIMESTAMP_KEY = 'token_timestamp';
  static const String PROVIDER_TOKEN_TIMESTAMP_KEY = 'provider_token_timestamp';

  // Add keys for token status
  static const String IS_USER_KEY = 'is-user';
  static const String IS_PROVIDER_KEY = 'is-user-provider';
  static const String TOKEN_KEY = 'token';
  static const String PROVIDER_TOKEN_KEY = 'token-provider';

  Future<void> initialize() async {
    await _checkInitialTokenStatus();
    _startTokenCheck();
  }

  Future<void> _checkInitialTokenStatus() async {
    final prefs = await SharedPreferences.getInstance();

    // Check and initialize timestamps if needed
    if (prefs.getInt(TOKEN_TIMESTAMP_KEY) == null) {
      await _updateTokenTimestamp(false);
    }
    if (prefs.getInt(PROVIDER_TOKEN_TIMESTAMP_KEY) == null) {
      await _updateTokenTimestamp(true);
    }

    // Perform initial token expiration check
    await _checkAndRefreshTokens();
  }

  Future<void> _updateTokenTimestamp(bool isProvider) async {
    final prefs = await SharedPreferences.getInstance();
    final key = isProvider ? PROVIDER_TOKEN_TIMESTAMP_KEY : TOKEN_TIMESTAMP_KEY;
    await prefs.setInt(key, DateTime.now().millisecondsSinceEpoch);
  }

  void _startTokenCheck() {
    _refreshTimer?.cancel();
    _refreshTimer = Timer.periodic(const Duration(minutes: 5), (timer) async {
      await _checkAndRefreshTokens();
    });
  }

  Future<void> _checkAndRefreshTokens() async {
    final prefs = await SharedPreferences.getInstance();

    // Check regular user token
    if (prefs.getBool(IS_USER_KEY) == true) {
      final userTimestamp = prefs.getInt(TOKEN_TIMESTAMP_KEY);
      if (userTimestamp != null) {
        final elapsed = DateTime.now().millisecondsSinceEpoch - userTimestamp;
        if (elapsed >= TOKEN_EXPIRATION) {
          await _handleRefreshFailure(false);
          _navigateToLogin();
        }
      }
    }

    // Check provider token
    if (prefs.getBool(IS_PROVIDER_KEY) == true) {
      final providerTimestamp = prefs.getInt(PROVIDER_TOKEN_TIMESTAMP_KEY);
      if (providerTimestamp != null) {
        final elapsed =
            DateTime.now().millisecondsSinceEpoch - providerTimestamp;
        if (elapsed >= TOKEN_EXPIRATION) {
          await _handleRefreshFailure(true);
          _navigateToLogin();
        }
      }
    }
  }

  Future<void> _handleRefreshFailure(bool isProvider) async {
    final prefs = await SharedPreferences.getInstance();
    if (isProvider) {
      await prefs.remove(IS_PROVIDER_KEY);
      await prefs.remove(PROVIDER_TOKEN_KEY);
      await prefs.remove(PROVIDER_TOKEN_TIMESTAMP_KEY);
    } else {
      await prefs.remove(IS_USER_KEY);
      await prefs.remove(TOKEN_KEY);
      await prefs.remove(TOKEN_TIMESTAMP_KEY);
    }
  }

  void _navigateToLogin() {
    // Using GetX navigation to route to login
    Get.offAllNamed('/login');

    // Show session expired dialog
    Get.dialog(
      AlertDialog(
        title: Text('Session Expired'),
        content: Text('Your session has expired. Please login again.'),
        actions: [
          TextButton(
            child: Text('OK'),
            onPressed: () => Get.back(),
          ),
        ],
      ),
    );
  }

  // Method to manually reset token timestamp (useful after successful login)
  Future<void> resetTokenTimestamp({required bool isProvider}) async {
    await _updateTokenTimestamp(isProvider);
  }

  void dispose() {
    _refreshTimer?.cancel();
  }
}
