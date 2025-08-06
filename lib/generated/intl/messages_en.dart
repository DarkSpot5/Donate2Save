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

  static String m0(bloodType) => "Please enter quantity for ${bloodType}";

  static String m1(bloodType) => "Enter a valid number for ${bloodType}";

  static String m2(email) =>
      "Password reset instructions have been sent to ${email}.";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
    "appSubtitle": MessageLookupByLibrary.simpleMessage("Health Care"),
    "appTitle": MessageLookupByLibrary.simpleMessage("Donate2Save"),
    "bloodGroupLabel": MessageLookupByLibrary.simpleMessage("Blood Group"),
    "confirmPasswordLabel": MessageLookupByLibrary.simpleMessage(
      "Confirm Password",
    ),
    "contactNumberLabel": MessageLookupByLibrary.simpleMessage(
      "Contact Number",
    ),
    "emailLabel": MessageLookupByLibrary.simpleMessage("Email"),
    "emailSentTitle": MessageLookupByLibrary.simpleMessage("Email Sent"),
    "emailVerificationSent": MessageLookupByLibrary.simpleMessage(
      "A verification link has been sent to your email.",
    ),
    "emailVerificationSentSubtitle": MessageLookupByLibrary.simpleMessage(
      "Please check your inbox and click on the verification link.\nIf you do not see the email, please check your spam folder.",
    ),
    "emailVerificationTitle": MessageLookupByLibrary.simpleMessage(
      "Email Verification",
    ),
    "errorAllFieldsRequired": MessageLookupByLibrary.simpleMessage(
      "All fields are required.",
    ),
    "errorEnterBloodStock": m0,
    "errorEnterContact": MessageLookupByLibrary.simpleMessage(
      "Please enter the Contact Number",
    ),
    "errorEnterEmail": MessageLookupByLibrary.simpleMessage(
      "Please enter your email address.",
    ),
    "errorEnterHospitalName": MessageLookupByLibrary.simpleMessage(
      "Please enter the Hospital Name",
    ),
    "errorEnterLocation": MessageLookupByLibrary.simpleMessage(
      "Please insert your Location",
    ),
    "errorEnterName": MessageLookupByLibrary.simpleMessage(
      "Please enter the Name",
    ),
    "errorInvalidBloodStock": m1,
    "errorInvalidContact": MessageLookupByLibrary.simpleMessage(
      "Enter a valid 11-digit Contact Number",
    ),
    "errorInvalidEmail": MessageLookupByLibrary.simpleMessage(
      "Please enter a valid email address.",
    ),
    "errorPasswordRequirements": MessageLookupByLibrary.simpleMessage(
      "Password must contain uppercase, lowercase, number, and special character.",
    ),
    "errorPasswordTooShort": MessageLookupByLibrary.simpleMessage(
      "Password must be at least 8 characters long.",
    ),
    "errorPasswordsDoNotMatch": MessageLookupByLibrary.simpleMessage(
      "Passwords do not match.",
    ),
    "errorRoleNotSelected": MessageLookupByLibrary.simpleMessage(
      "Please select a role.",
    ),
    "errorSelectBloodGroup": MessageLookupByLibrary.simpleMessage(
      "Please select your Blood Group",
    ),
    "errorSelectGender": MessageLookupByLibrary.simpleMessage(
      "Please select your Gender",
    ),
    "femaleLabel": MessageLookupByLibrary.simpleMessage("Female"),
    "forgotPassword": MessageLookupByLibrary.simpleMessage("Forgot Password"),
    "forgotPasswordLink": MessageLookupByLibrary.simpleMessage(
      "Forgot Password?",
    ),
    "genderLabel": MessageLookupByLibrary.simpleMessage("Gender"),
    "hospitalNameLabel": MessageLookupByLibrary.simpleMessage("Hospital Name"),
    "iVerifiedMyEmail": MessageLookupByLibrary.simpleMessage(
      "I verified My Email",
    ),
    "initialBloodStock": MessageLookupByLibrary.simpleMessage(
      "Initial Blood Stock",
    ),
    "languageToggle": MessageLookupByLibrary.simpleMessage("اردو"),
    "locationLabel": MessageLookupByLibrary.simpleMessage("Location"),
    "loginButton": MessageLookupByLibrary.simpleMessage("Login"),
    "maleLabel": MessageLookupByLibrary.simpleMessage("Male"),
    "noNotifications": MessageLookupByLibrary.simpleMessage(
      "No new notifications.",
    ),
    "orDivider": MessageLookupByLibrary.simpleMessage("or"),
    "otherLabel": MessageLookupByLibrary.simpleMessage("Other"),
    "passwordLabel": MessageLookupByLibrary.simpleMessage("Password"),
    "registerButton": MessageLookupByLibrary.simpleMessage("Register"),
    "registerCreateAccount": MessageLookupByLibrary.simpleMessage(
      "Create Account",
    ),
    "registerTitle": MessageLookupByLibrary.simpleMessage("Register"),
    "resendVerificationEmail": MessageLookupByLibrary.simpleMessage(
      "Resend Verification Email",
    ),
    "resetEmailSent": m2,
    "resetYourPassword": MessageLookupByLibrary.simpleMessage(
      "Reset Your Password",
    ),
    "saveProfileButton": MessageLookupByLibrary.simpleMessage("Save Profile"),
    "searchHint": MessageLookupByLibrary.simpleMessage("Search hospitals"),
    "selectRoleLabel": MessageLookupByLibrary.simpleMessage("Select Role"),
    "sendResetEmail": MessageLookupByLibrary.simpleMessage("Send Reset Email"),
    "setupProfileTitle": MessageLookupByLibrary.simpleMessage("Setup Profile"),
    "userNameLabel": MessageLookupByLibrary.simpleMessage("User Name"),
  };
}
