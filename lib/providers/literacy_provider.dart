import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:stones_classifier/common/exceptions/app_exception.dart';
import 'package:stones_classifier/models/generic_response_model.dart';
import 'package:stones_classifier/models/literacy_model.dart';
import 'package:stones_classifier/services/literacy_service.dart';

class LiteracyProvider with ChangeNotifier {
  final _literacyService = LiteracyService();
  GenericResponseModel<List<LiteracyModel>>? _literacies;
  GenericResponseModel<List<LiteracyModel>>? get literacies => _literacies;
  GenericResponseModel<LiteracyModel>? _literacy;
  GenericResponseModel<LiteracyModel>? get literacy => _literacy;
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  Future<bool> getAllLiteracy() async {
    try {
      setLoading(true);

      final data = await _literacyService.getAllLiteracy();

      _literacies = data;

      setLoading(false);

      if (_literacies?.metadata?.code == 200) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      log("Error get all literacy provider: $e");
      throw AppException(
          "Terjadi kesalahan saat mengambil data. Silakan coba lagi.");
    }
  }

  Future<bool> getLiteracy(int literacyId) async {
    try {
      setLoading(true);

      final data = await _literacyService.getLiteracy(literacyId);

      _literacy = data;

      setLoading(false);

      if (_literacy?.metadata?.code == 200) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      log("Error get literacy provider: $e");
      throw AppException(
          "Terjadi kesalahan saat mengambil data. Silakan coba lagi.");
    }
  }
}
