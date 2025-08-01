// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a en locale. All the
// messages from the main program should be duplicated here with the same
// function name.

// Ignore issues from commonly used lints in this file.
// ignore_for_file:unnecessary_brace_in_string_interps, unnecessary_new
// ignore_for_file:prefer_single_quotes,comment_references, directives_ordering
// ignore_for_file:annotate_overrides,prefer_generic_function_type_aliases
// ignore_for_file:unused_import, file_names, avoid_escaping_inner_quotes
// ignore_for_file:unnecessary_string_interpolations, unnecessary_string_escapes

import 'package:intl/intl.dart';
import 'package:intl/message_lookup_by_library.dart';

final messages = new MessageLookup();

typedef String MessageIfAbsent(String messageStr, List<dynamic> args);

class MessageLookup extends MessageLookupByLibrary {
  String get localeName => 'en';

  static String m0(email) =>
      "Password reset instructions have been sent to ${email}.";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
    "appSubtitle": MessageLookupByLibrary.simpleMessage("Health Care"),
    "appTitle": MessageLookupByLibrary.simpleMessage("Donate2Save"),
    "confirmPasswordLabel": MessageLookupByLibrary.simpleMessage(
      "Confirm Password",
    ),
    "emailLabel": MessageLookupByLibrary.simpleMessage("Email"),
    "emailSentTitle": MessageLookupByLibrary.simpleMessage("Email Sent"),
    "forgotPassword": MessageLookupByLibrary.simpleMessage("Forgot Password"),
    "forgotPasswordLink": MessageLookupByLibrary.simpleMessage(
      "Forgot Password?",
    ),
    "languageToggle": MessageLookupByLibrary.simpleMessage("اردو"),
    "loginButton": MessageLookupByLibrary.simpleMessage("Login"),
    "noNotifications": MessageLookupByLibrary.simpleMessage(
      "No new notifications.",
    ),
    "orDivider": MessageLookupByLibrary.simpleMessage("or"),
    "passwordLabel": MessageLookupByLibrary.simpleMessage("Password"),
    "registerButton": MessageLookupByLibrary.simpleMessage("Register"),
    "registerCreateAccount": MessageLookupByLibrary.simpleMessage(
      "Create Account",
    ),
    "registerTitle": MessageLookupByLibrary.simpleMessage("Register"),
    "resetEmailSent": m0,
    "resetYourPassword": MessageLookupByLibrary.simpleMessage(
      "Reset Your Password",
    ),
    "roleHospital": MessageLookupByLibrary.simpleMessage("Hospital"),
    "roleUser": MessageLookupByLibrary.simpleMessage("User"),
    "searchHint": MessageLookupByLibrary.simpleMessage("Search hospitals"),
    "selectRoleLabel": MessageLookupByLibrary.simpleMessage("Select Role"),
    "sendResetEmail": MessageLookupByLibrary.simpleMessage("Send Reset Email"),
  };
}
