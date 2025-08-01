import 'package:flutter/material.dart';

class LoadingController with ChangeNotifier {
  bool _isLoading = false;

  bool get isLoading => _isLoading;

  void startLoading() {
    _isLoading = true;
    notifyListeners();
  }

  void stopLoading() {
    _isLoading = false;
    notifyListeners();
  }

  void setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }
}