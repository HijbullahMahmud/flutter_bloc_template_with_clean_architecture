import '../local/cache_service.dart';

class TokenManager {
  final CacheService _cacheService;

  TokenManager(this._cacheService);

  // Save tokens
  Future<void> saveTokens({
    required String accessToken,
    String? refreshToken,
    DateTime? expiryTime,
  }) async {
    await _cacheService.save(CacheKey.accessToken, accessToken);
    if (refreshToken != null) {
      await _cacheService.save(CacheKey.refreshToken, refreshToken);
    }
    if (expiryTime != null) {
      await _cacheService.save(
        CacheKey.tokenExpiry,
        expiryTime.toIso8601String(),
      );
    }
  }

  // Get access token
  String? getAccessToken() {
    return _cacheService.get<String>(CacheKey.accessToken);
  }

  // Get refresh token
  String? getRefreshToken() {
    return _cacheService.get<String>(CacheKey.refreshToken);
  }

  // Check if token is expired
  bool isTokenExpired() {
    final expiryString = _cacheService.get<String>(CacheKey.tokenExpiry);
    if (expiryString == null) return false;

    final expiryTime = DateTime.parse(expiryString);
    return DateTime.now().isAfter(expiryTime);
  }

  // Check if token exists
  bool hasToken() {
    return getAccessToken() != null;
  }

  // Clear all tokens
  Future<void> clearTokens() async {
    await _cacheService.remove([
      CacheKey.accessToken,
      CacheKey.refreshToken,
      CacheKey.tokenExpiry,
    ]);
  }

  // Get authorization header
  String? getAuthorizationHeader() {
    final token = getAccessToken();
    return token != null ? 'Bearer $token' : null;
  }
}
