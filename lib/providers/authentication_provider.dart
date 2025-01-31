import 'dart:developer';
import 'package:flutter/foundation.dart';
import 'package:stones_classifier/models/authentication_model.dart';
import 'package:stones_classifier/models/generic_response_model.dart';
import 'package:stones_classifier/services/authentication_service.dart';
import '../common/exceptions/app_exception.dart';

class AuthenticationProvider with ChangeNotifier {
  final _authenticationService = AuthenticationService();
  AuthenticationModel? _authenticationModel;
  AuthenticationModel? get authenticationModel => _authenticationModel;
  GenericResponseModel? _genericResponseModel;
  GenericResponseModel? get genericResponseModel => _genericResponseModel;
  bool _isLoading = false;
  bool get isLoading => _isLoading;
  bool _isObscureText = true;
  bool get isObscureText => _isObscureText;
  bool _isObscureTextConfirm = true;
  bool get isObscureTextConfirm => _isObscureTextConfirm;

  setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  setObscureText() {
    _isObscureText = !_isObscureText;
    notifyListeners();
  }

  setObscureTextConfirm() {
    _isObscureTextConfirm = !_isObscureTextConfirm;
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

      setLoading(false);
      if (_authenticationModel?.genericResponseModel?.metadata?.code == 200) {
        return true;
      } else {
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

      setLoading(false);
      if (_authenticationModel?.genericResponseModel?.metadata?.code == 200) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      setLoading(false);
      log("Error sign in with google provider: $e");
      throw AppException("Terjadi kesalahan saat masuk. Silakan coba lagi.");
    }
  }

  Future<bool> requestOtp(String email) async {
    try {
      setLoading(true);

      final data = await _authenticationService.requestOtp(email);

      _genericResponseModel = data;

      setLoading(false);

      if (_genericResponseModel?.metadata?.code == 200) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      setLoading(false);
      log("Error request otp provider: $e");
      throw AppException(
          "Terjadi kesalahan saat memuat data. Silakan coba lagi.");
    }
  }

  Future<bool> validateOtp(
    String email,
    String otp,
  ) async {
    try {
      setLoading(true);

      final data = await _authenticationService.validateOtp(
        email,
        otp,
      );

      _genericResponseModel = data;

      setLoading(false);

      if (_genericResponseModel?.metadata?.code == 200) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      setLoading(false);
      log("Error validate otp provider: $e");
      throw AppException(
          "Terjadi kesalahan saat memuat data. Silakan coba lagi.");
    }
  }

  Future<bool> changePassword(
    String email,
    String password,
  ) async {
    try {
      setLoading(true);

      final data = await _authenticationService.changePassword(
        email,
        password,
      );

      _genericResponseModel = data;

      setLoading(false);

      if (_genericResponseModel?.metadata?.code == 200) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      setLoading(false);
      log("Error change password provider: $e");
      throw AppException(
          "Terjadi kesalahan saat memuat data. Silakan coba lagi.");
    }
  }
}
