class ErrorMessages {
  static String firebase(String errorCode) {
    switch (errorCode) {
      case 'network-request-failed':
        return 'Check your internet connection.';
      case 'user-disabled':
        return 'This user has been disabled.';
      case 'too-many-requests':
        return 'Too many attempts. Try again later.';
      case 'user-token-expired':
        return 'You are no longer authenticated since your refresh token has been expired.';
      case 'user-not-found':
        return 'No account found with this email.';
      case 'wrong-password':
        return 'Incorrect password.';
      case 'email-already-in-use':
        return 'Email already registered. Try logging in.';
      case 'invalid-email':
        return 'Invalid email address.';
      case 'weak-password':
        return 'The password is too weak.';
      case 'INVALID_LOGIN_CREDENTIALS':
      case 'invalid-credential':
      return 'Invalid Credentials\nYou have account?';
      default:
        return 'Something went wrong. Please try again.';
    }
  }
}