// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(
      _current != null,
      'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.',
    );
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(
      instance != null,
      'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?',
    );
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `Register`
  String get registerTitle {
    return Intl.message('Register', name: 'registerTitle', desc: '', args: []);
  }

  /// `Create Account`
  String get registerCreateAccount {
    return Intl.message(
      'Create Account',
      name: 'registerCreateAccount',
      desc: '',
      args: [],
    );
  }

  /// `Email`
  String get emailLabel {
    return Intl.message('Email', name: 'emailLabel', desc: '', args: []);
  }

  /// `Password`
  String get passwordLabel {
    return Intl.message('Password', name: 'passwordLabel', desc: '', args: []);
  }

  /// `Confirm Password`
  String get confirmPasswordLabel {
    return Intl.message(
      'Confirm Password',
      name: 'confirmPasswordLabel',
      desc: '',
      args: [],
    );
  }

  /// `Select Role`
  String get selectRoleLabel {
    return Intl.message(
      'Select Role',
      name: 'selectRoleLabel',
      desc: '',
      args: [],
    );
  }

  /// `Register`
  String get registerButton {
    return Intl.message('Register', name: 'registerButton', desc: '', args: []);
  }

  /// `Forgot Password`
  String get forgotPassword {
    return Intl.message(
      'Forgot Password',
      name: 'forgotPassword',
      desc: '',
      args: [],
    );
  }

  /// `Reset Your Password`
  String get resetYourPassword {
    return Intl.message(
      'Reset Your Password',
      name: 'resetYourPassword',
      desc: '',
      args: [],
    );
  }

  /// `Send Reset Email`
  String get sendResetEmail {
    return Intl.message(
      'Send Reset Email',
      name: 'sendResetEmail',
      desc: '',
      args: [],
    );
  }

  /// `Email Sent`
  String get emailSentTitle {
    return Intl.message(
      'Email Sent',
      name: 'emailSentTitle',
      desc: '',
      args: [],
    );
  }

  /// `Password reset instructions have been sent to {email}.`
  String resetEmailSent(Object email) {
    return Intl.message(
      'Password reset instructions have been sent to $email.',
      name: 'resetEmailSent',
      desc: 'Message shown after sending a password reset email',
      args: [email],
    );
  }

  /// `Donate2Save`
  String get appTitle {
    return Intl.message('Donate2Save', name: 'appTitle', desc: '', args: []);
  }

  /// `Health Care`
  String get appSubtitle {
    return Intl.message('Health Care', name: 'appSubtitle', desc: '', args: []);
  }

  /// `Forgot Password?`
  String get forgotPasswordLink {
    return Intl.message(
      'Forgot Password?',
      name: 'forgotPasswordLink',
      desc: '',
      args: [],
    );
  }

  /// `Login`
  String get loginButton {
    return Intl.message('Login', name: 'loginButton', desc: '', args: []);
  }

  /// `or`
  String get orDivider {
    return Intl.message('or', name: 'orDivider', desc: '', args: []);
  }

  /// `Email Verification`
  String get emailVerificationTitle {
    return Intl.message(
      'Email Verification',
      name: 'emailVerificationTitle',
      desc: '',
      args: [],
    );
  }

  /// `A verification link has been sent to your email.`
  String get emailVerificationSent {
    return Intl.message(
      'A verification link has been sent to your email.',
      name: 'emailVerificationSent',
      desc: '',
      args: [],
    );
  }

  /// `Please check your inbox and click on the verification link.\nIf you do not see the email, please check your spam folder.`
  String get emailVerificationSentSubtitle {
    return Intl.message(
      'Please check your inbox and click on the verification link.\nIf you do not see the email, please check your spam folder.',
      name: 'emailVerificationSentSubtitle',
      desc: '',
      args: [],
    );
  }

  /// `I verified My Email`
  String get iVerifiedMyEmail {
    return Intl.message(
      'I verified My Email',
      name: 'iVerifiedMyEmail',
      desc: '',
      args: [],
    );
  }

  /// `Resend Verification Email`
  String get resendVerificationEmail {
    return Intl.message(
      'Resend Verification Email',
      name: 'resendVerificationEmail',
      desc: '',
      args: [],
    );
  }

  /// `User Name`
  String get userNameLabel {
    return Intl.message('User Name', name: 'userNameLabel', desc: '', args: []);
  }

  /// `Blood Group`
  String get bloodGroupLabel {
    return Intl.message(
      'Blood Group',
      name: 'bloodGroupLabel',
      desc: '',
      args: [],
    );
  }

  /// `Gender`
  String get genderLabel {
    return Intl.message('Gender', name: 'genderLabel', desc: '', args: []);
  }

  /// `Male`
  String get maleLabel {
    return Intl.message('Male', name: 'maleLabel', desc: '', args: []);
  }

  /// `Female`
  String get femaleLabel {
    return Intl.message('Female', name: 'femaleLabel', desc: '', args: []);
  }

  /// `Other`
  String get otherLabel {
    return Intl.message('Other', name: 'otherLabel', desc: '', args: []);
  }

  /// `Hospital Name`
  String get hospitalNameLabel {
    return Intl.message(
      'Hospital Name',
      name: 'hospitalNameLabel',
      desc: '',
      args: [],
    );
  }

  /// `Initial Blood Stock`
  String get initialBloodStock {
    return Intl.message(
      'Initial Blood Stock',
      name: 'initialBloodStock',
      desc: '',
      args: [],
    );
  }

  /// `Setup Profile`
  String get setupProfileTitle {
    return Intl.message(
      'Setup Profile',
      name: 'setupProfileTitle',
      desc: '',
      args: [],
    );
  }

  /// `Contact Number`
  String get contactNumberLabel {
    return Intl.message(
      'Contact Number',
      name: 'contactNumberLabel',
      desc: '',
      args: [],
    );
  }

  /// `Location`
  String get locationLabel {
    return Intl.message('Location', name: 'locationLabel', desc: '', args: []);
  }

  /// `Save Profile`
  String get saveProfileButton {
    return Intl.message(
      'Save Profile',
      name: 'saveProfileButton',
      desc: '',
      args: [],
    );
  }

  /// `Search hospitals`
  String get searchHint {
    return Intl.message(
      'Search hospitals',
      name: 'searchHint',
      desc: '',
      args: [],
    );
  }

  /// `No new notifications.`
  String get noNotifications {
    return Intl.message(
      'No new notifications.',
      name: 'noNotifications',
      desc: '',
      args: [],
    );
  }

  /// `All fields are required.`
  String get errorAllFieldsRequired {
    return Intl.message(
      'All fields are required.',
      name: 'errorAllFieldsRequired',
      desc: '',
      args: [],
    );
  }

  /// `Please enter your email address.`
  String get errorEnterEmail {
    return Intl.message(
      'Please enter your email address.',
      name: 'errorEnterEmail',
      desc: '',
      args: [],
    );
  }

  /// `Please enter a valid email address.`
  String get errorInvalidEmail {
    return Intl.message(
      'Please enter a valid email address.',
      name: 'errorInvalidEmail',
      desc: '',
      args: [],
    );
  }

  /// `Passwords do not match.`
  String get errorPasswordsDoNotMatch {
    return Intl.message(
      'Passwords do not match.',
      name: 'errorPasswordsDoNotMatch',
      desc: '',
      args: [],
    );
  }

  /// `Password must be at least 8 characters long.`
  String get errorPasswordTooShort {
    return Intl.message(
      'Password must be at least 8 characters long.',
      name: 'errorPasswordTooShort',
      desc: '',
      args: [],
    );
  }

  /// `Password must contain uppercase, lowercase, number, and special character.`
  String get errorPasswordRequirements {
    return Intl.message(
      'Password must contain uppercase, lowercase, number, and special character.',
      name: 'errorPasswordRequirements',
      desc: '',
      args: [],
    );
  }

  /// `Please select a role.`
  String get errorRoleNotSelected {
    return Intl.message(
      'Please select a role.',
      name: 'errorRoleNotSelected',
      desc: '',
      args: [],
    );
  }

  /// `Please enter the Name`
  String get errorEnterName {
    return Intl.message(
      'Please enter the Name',
      name: 'errorEnterName',
      desc: '',
      args: [],
    );
  }

  /// `Please enter the Hospital Name`
  String get errorEnterHospitalName {
    return Intl.message(
      'Please enter the Hospital Name',
      name: 'errorEnterHospitalName',
      desc: '',
      args: [],
    );
  }

  /// `Please enter the Contact Number`
  String get errorEnterContact {
    return Intl.message(
      'Please enter the Contact Number',
      name: 'errorEnterContact',
      desc: '',
      args: [],
    );
  }

  /// `Enter a valid 11-digit Contact Number`
  String get errorInvalidContact {
    return Intl.message(
      'Enter a valid 11-digit Contact Number',
      name: 'errorInvalidContact',
      desc: '',
      args: [],
    );
  }

  /// `Please select your Blood Group`
  String get errorSelectBloodGroup {
    return Intl.message(
      'Please select your Blood Group',
      name: 'errorSelectBloodGroup',
      desc: '',
      args: [],
    );
  }

  /// `Please insert your Location`
  String get errorEnterLocation {
    return Intl.message(
      'Please insert your Location',
      name: 'errorEnterLocation',
      desc: '',
      args: [],
    );
  }

  /// `Please select your Gender`
  String get errorSelectGender {
    return Intl.message(
      'Please select your Gender',
      name: 'errorSelectGender',
      desc: '',
      args: [],
    );
  }

  /// `Please enter quantity for {bloodType}`
  String errorEnterBloodStock(Object bloodType) {
    return Intl.message(
      'Please enter quantity for $bloodType',
      name: 'errorEnterBloodStock',
      desc:
          'Shown when quantity field for a blood group (e.g., A+, B-) is empty',
      args: [bloodType],
    );
  }

  /// `Enter a valid number for {bloodType}`
  String errorInvalidBloodStock(Object bloodType) {
    return Intl.message(
      'Enter a valid number for $bloodType',
      name: 'errorInvalidBloodStock',
      desc:
          'Shown when quantity field for a blood group (e.g., A+, B-) has invalid number',
      args: [bloodType],
    );
  }

  /// `User is null.`
  String get error_user_null {
    return Intl.message(
      'User is null.',
      name: 'error_user_null',
      desc: '',
      args: [],
    );
  }

  /// `User document does not exist.`
  String get error_user_not_found {
    return Intl.message(
      'User document does not exist.',
      name: 'error_user_not_found',
      desc: '',
      args: [],
    );
  }

  /// `Invalid role returned from Firestore.`
  String get error_invalid_role {
    return Intl.message(
      'Invalid role returned from Firestore.',
      name: 'error_invalid_role',
      desc: '',
      args: [],
    );
  }

  /// `Check your internet connection.`
  String get error_networkRequestFailed {
    return Intl.message(
      'Check your internet connection.',
      name: 'error_networkRequestFailed',
      desc: '',
      args: [],
    );
  }

  /// `This user has been disabled.`
  String get error_userDisabled {
    return Intl.message(
      'This user has been disabled.',
      name: 'error_userDisabled',
      desc: '',
      args: [],
    );
  }

  /// `Too many attempts. Try again later.`
  String get error_tooManyRequests {
    return Intl.message(
      'Too many attempts. Try again later.',
      name: 'error_tooManyRequests',
      desc: '',
      args: [],
    );
  }

  /// `You are no longer authenticated since your refresh token has expired.`
  String get error_userTokenExpired {
    return Intl.message(
      'You are no longer authenticated since your refresh token has expired.',
      name: 'error_userTokenExpired',
      desc: '',
      args: [],
    );
  }

  /// `No account found with this email.`
  String get error_userNotFound {
    return Intl.message(
      'No account found with this email.',
      name: 'error_userNotFound',
      desc: '',
      args: [],
    );
  }

  /// `Incorrect password.`
  String get error_wrongPassword {
    return Intl.message(
      'Incorrect password.',
      name: 'error_wrongPassword',
      desc: '',
      args: [],
    );
  }

  /// `Email already registered. Try logging in.`
  String get error_emailAlreadyInUse {
    return Intl.message(
      'Email already registered. Try logging in.',
      name: 'error_emailAlreadyInUse',
      desc: '',
      args: [],
    );
  }

  /// `Invalid email address.`
  String get error_invalidEmail {
    return Intl.message(
      'Invalid email address.',
      name: 'error_invalidEmail',
      desc: '',
      args: [],
    );
  }

  /// `The password is too weak.`
  String get error_weakPassword {
    return Intl.message(
      'The password is too weak.',
      name: 'error_weakPassword',
      desc: '',
      args: [],
    );
  }

  /// `Invalid Credentials\nDo you have an account?`
  String get error_invalidCredentials {
    return Intl.message(
      'Invalid Credentials\nDo you have an account?',
      name: 'error_invalidCredentials',
      desc: '',
      args: [],
    );
  }

  /// `An Android package name must be provided if the Android app is required to be installed.`
  String get error_missingAndroidPkgName {
    return Intl.message(
      'An Android package name must be provided if the Android app is required to be installed.',
      name: 'error_missingAndroidPkgName',
      desc: '',
      args: [],
    );
  }

  /// `An unexpected error occurred: {error}`
  String error_unexpected(Object error) {
    return Intl.message(
      'An unexpected error occurred: $error',
      name: 'error_unexpected',
      desc: 'Error with exact code. so developer can get an idea about error.',
      args: [error],
    );
  }

  /// `Something went wrong. Please try again.`
  String get error_default {
    return Intl.message(
      'Something went wrong. Please try again.',
      name: 'error_default',
      desc: '',
      args: [],
    );
  }

  /// `اردو`
  String get languageToggle {
    return Intl.message('اردو', name: 'languageToggle', desc: '', args: []);
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'ur'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
