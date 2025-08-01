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

  /// `User`
  String get roleUser {
    return Intl.message('User', name: 'roleUser', desc: '', args: []);
  }

  /// `Hospital`
  String get roleHospital {
    return Intl.message('Hospital', name: 'roleHospital', desc: '', args: []);
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
