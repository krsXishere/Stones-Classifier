import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:stones_classifier/common/exceptions/app_exception.dart';
import 'package:stones_classifier/services/history_service.dart';
import '../models/generic_response_model.dart';

class HistoryProvider with ChangeNotifier {
  final _historyService = HistoryService();
  GenericResponseModel? _historiesModel;
  GenericResponseModel? get historiesModel => _historiesModel;
  bool _isLoading = false;
  bool get isLoading => _isLoading;
  int? _userId;
  String? _search;

  setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  setUserId(int value) {
    _userId = value;
    notifyListeners();
  }

  setSearch(String value) {
    _search = value;
    notifyListeners();
  }

  Future<bool> getHistory() async {
    try {
      setLoading(true);

      if (_userId == null) return false;

      final data = await _historyService.getHistory(
        _userId!,
        search: _search,
      );

      _historiesModel = data;

      if (_historiesModel?.metadata?.code == 200) {
        setLoading(false);

        return true;
      } else {
        setLoading(false);

        return false;
      }
    } catch (e) {
      log("Error get history provider: $e");
      throw AppException(
          "Terjadi kesalahan saat mengambil data. Silakan coba lagi.");
    }
  }
}
