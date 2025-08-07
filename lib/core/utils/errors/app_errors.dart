import 'package:flutter/material.dart';
import '../../../generated/l10n.dart';

class AppErrors {
  static String getMessage(BuildContext context, String errorCode) {
    final s = S.of(context);

    switch (errorCode) {
      case 'user_null':
        return s.error_user_null;
      case 'user_not_found':
        return s.error_user_not_found;
      case 'invalid_role':
        return s.error_invalid_role;
      case 'failed_to_update_profile':
        return s.error_failed_to_update_profile;
      default:
        return s.error_default; // Optional fallback like "An unknown error occurred"
    }
  }
}