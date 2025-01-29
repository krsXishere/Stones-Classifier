import 'dart:developer';
import 'package:flutter/foundation.dart';
import 'package:stones_classifier/models/authentication_model.dart';
import 'package:stones_classifier/services/authentication_service.dart';
import '../common/exceptions/app_exception.dart';

class AuthenticationProvider with ChangeNotifier {
  final _authenticationService = AuthenticationService();
  AuthenticationModel? _authenticationModel;
  AuthenticationModel? get authenticationModel => _authenticationModel;
  bool _isLoading = false;
  bool get isLoading => _isLoading;
  bool _isObscureText = true;
  bool get isObscureText => _isObscureText;

  setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  setObscureText() {
    _isObscureText = !_isObscureText;
    notifyListeners();
  }

  Future<bool> signIn(
    String email,
    String password,
  ) async {
    try {
      setLoading(true);

      final data = await _authenticationService.signIn(
        email,
        password,
      );

      _authenticationModel = data;

      if (_authenticationModel?.genericResponseModel?.metadata?.code == 200) {
        setLoading(false);

        return true;
      } else {
        setLoading(false);

        return false;
      }
    } catch (e) {
      setLoading(false);
      log("Error sign in provider: $e");
      throw AppException("Terjadi kesalahan saat masuk. Silakan coba lagi.");
    }
  }

  Future<bool> signInWithGoogle() async {
    try {
      setLoading(true);

      final data = await _authenticationService.signInWithGoogle();

      _authenticationModel = data;

      if (_authenticationModel?.genericResponseModel?.metadata?.code == 200) {
        setLoading(false);

        return true;
      } else {
        setLoading(false);

        return false;
      }
    } catch (e) {
      setLoading(false);
      log("Error sign in with google provider: $e");
      throw AppException("Terjadi kesalahan saat masuk. Silakan coba lagi.");
    }
  }
}
