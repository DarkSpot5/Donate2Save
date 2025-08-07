import '../../../generated/l10n.dart';
import '../../services/navigation_service.dart';

class SuccessMessages {
  static String success(String successCode) {
    final context = NavigationService.navigatorKey.currentContext!;
    final s = S.of(context);

    switch (successCode) {
      case 'email_sent_title':
        return s.emailSentTitle; // "Email Sent"
      case 'reset_email_sent_message':
        return s.resetEmailSent; // "Password reset email sent successfully."
      case 'verified_title':
        return s.verifiedTitle; // "Verified"
      case 'verified_subtitle':
        return s.verifiedSubtitle; // "Your email has been verified successfully. You can now proceed to set up your profile."
      case 'not_verified_title':
        return s.notVerifiedTitle; // "Email Not Verified"
      case 'not_verified_subtitle':
        return s.notVerifiedSubtitle; // "Your email is not verified. Please check your inbox
      case 'profile_updated':
        return s.profile_updated;
      default:
        return s.unknownSuccess; // Fallback message
    }
}
}