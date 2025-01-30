import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:stones_classifier/common/exceptions/app_exception.dart';
import 'package:stones_classifier/models/collection_model.dart';
import 'package:stones_classifier/models/generic_response_model.dart';
import 'package:stones_classifier/services/collection_service.dart';

class CollectionProvider with ChangeNotifier {
  final _collectionService = CollectionService();
  GenericResponseModel<List<CollectionModel>>? _collectionsModel;
  GenericResponseModel<List<CollectionModel>>? get collectionsModel =>
      _collectionsModel;
  GenericResponseModel? _collectionModel;
  GenericResponseModel? get collectionModel => _collectionModel;
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

  Future<bool> saveToCollection(int historyId) async {
    try {
      setLoading(true);

      final data = await _collectionService.saveToCollection(historyId);

      _collectionModel = data;

      if (_collectionsModel?.metadata?.code == 200) {
        setLoading(false);

        return true;
      } else {
        setLoading(false);

        return false;
      }
    } catch (e) {
      log("Error save to collection provider: $e");
      throw AppException(
          "Terjadi kesalahan saat memuat data. Silakan coba lagi.");
    }
  }
}
