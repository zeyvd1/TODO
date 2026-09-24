class TokenManager {
  TokenManager._();

  static String? accessToken;
  static String? refreshToken;

  static void save({String? access, String? refresh}) {
    if (access != null) accessToken = access;
    if (refresh != null) refreshToken = refresh;
  }

  static void clear() {
    accessToken = null;
    refreshToken = null;
  }

  static bool get isLoggedIn => accessToken != null;
}
