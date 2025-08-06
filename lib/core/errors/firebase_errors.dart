import '../../generated/l10n.dart';
import '../services/navigation_service.dart';

class FirebaseErrors {
  static String firebase(String errorCode) {
    final context = NavigationService.navigatorKey.currentContext!;
    final s = S.of(context);

    switch (errorCode) {
      case 'network-request-failed':
        return s.error_networkRequestFailed;
      case 'user-disabled':
        return s.error_userDisabled;
      case 'too-many-requests':
        return s.error_tooManyRequests;
      case 'user-token-expired':
        return s.error_userTokenExpired;
      case 'user-not-found':
        return s.error_userNotFound;
      case 'wrong-password':
        return s.error_wrongPassword;
      case 'email-already-in-use':
        return s.error_emailAlreadyInUse;
      case 'invalid-email':
        return s.error_invalidEmail;
      case 'weak-password':
        return s.error_weakPassword;
      case 'INVALID_LOGIN_CREDENTIALS':
      case 'invalid-credential':
        return s.error_invalidCredentials;
      case 'missing-android-pkg-name':
        return s.error_missingAndroidPkgName;
      default:
        return s.error_unexpected(errorCode);
    }
  }
}