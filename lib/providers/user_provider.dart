import 'dart:developer';
import 'package:flutter/foundation.dart';
import 'package:stones_classifier/common/exceptions/app_exception.dart';
import 'package:stones_classifier/models/generic_response_model.dart';
import 'package:stones_classifier/services/user_service.dart';

class UserProvider with ChangeNotifier {
  final _userService = UserService();
  GenericResponseModel? _userModel;
  GenericResponseModel? get userModel => _userModel;
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  Future<bool> getProfileUser() async {
    try {
      setLoading(true);

      final data = await _userService.getProfileUser();

      _userModel = data;

      if (_userModel?.metadata?.code == 200) {
        setLoading(false);

        return true;
      } else {
        setLoading(false);

        return false;
      }
    } catch (e) {
      setLoading(false);
      log("Error get profile provider: $e");
      throw AppException("Terjadi kesalahan saat memuat. Silakan coba lagi.");
    }
  }
}
