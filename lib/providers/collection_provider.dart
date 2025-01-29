import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:stones_classifier/common/exceptions/app_exception.dart';
import 'package:stones_classifier/models/generic_response_model.dart';
import 'package:stones_classifier/services/collection_service.dart';

class CollectionProvider with ChangeNotifier {
  final _collectionService = CollectionService();
  GenericResponseModel? _collectionsModel;
  GenericResponseModel? get collectionsModel => _collectionsModel;
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  Future<bool> getCollection(int userId) async {
    try {
      setLoading(true);

      final data = await _collectionService.getCollection(userId);

      _collectionsModel = data;

      if (_collectionsModel?.metadata?.code == 200) {
        setLoading(false);

        return true;
      } else {
        setLoading(false);

        return false;
      }
    } catch (e) {
      log("Error get collection provider: $e");
      throw AppException(
          "Terjadi kesalahan saat mengambil data. Silakan coba lagi.");
    }
  }
}
