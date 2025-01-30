import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:stones_classifier/common/exceptions/app_exception.dart';
import 'package:stones_classifier/models/collection_model.dart';
import 'package:stones_classifier/models/generic_response_model.dart';
import 'package:stones_classifier/models/paginate_model.dart';
import 'package:stones_classifier/services/collection_service.dart';

class CollectionProvider with ChangeNotifier {
  final _collectionService = CollectionService();
  GenericResponseModel<List<CollectionModel>>? _collectionsModel;
  GenericResponseModel<List<CollectionModel>>? get collectionsModel =>
      _collectionsModel;
  GenericResponseModel<PaginateModel<List<CollectionModel>>>?
      _collectionsPaginatedModel;
  GenericResponseModel<PaginateModel<List<CollectionModel>>>?
      get collectionsPaginatedModel => _collectionsPaginatedModel;
  GenericResponseModel? _collectionModel;
  GenericResponseModel? get collectionModel => _collectionModel;
  bool _isLoading = false;
  bool get isLoading => _isLoading;
  int _skip = 0;
  final int _take = 5;
  final ScrollController _scrollController = ScrollController();
  ScrollController get scrollController => _scrollController;
  int? _userId;
  String? _search;

  CollectionProvider() {
    _scrollController.addListener(_onScroll);
  }

  setUserId(int value) {
    _userId = value;
    notifyListeners();
  }

  setSearch(
    {
    String? value,
    bool isClear = false,
  }) {
    if (isClear) {
      _search = null;
    } else {
      _search = value;
    }
    notifyListeners();
  }

  setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  Future<bool> getCollection() async {
    try {
      setLoading(true);

      if (_userId == null) return false;

      final data = await _collectionService.getCollection(
        _userId!,
        search: _search,
      );

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

  Future<bool> getCollectionsPaginated(int userId) async {
    try {
      setLoading(true);

      final data = await _collectionService.getCollectionsPaginated(
        userId,
        skip: _skip,
        take: _take,
        search: _search,
      );

      _collectionsPaginatedModel = data;

      if (_collectionsModel?.metadata?.code == 200) {
        setLoading(false);

        return true;
      } else {
        setLoading(false);

        return false;
      }
    } catch (e) {
      log("Error get collection paginated provider: $e");
      throw AppException(
          "Terjadi kesalahan saat mengambil data. Silakan coba lagi.");
    }
  }

  Future<bool> loadMoreCollections(int userId) async {
    try {
      setLoading(true);
      _skip += _take;

      final data = await _collectionService.getCollectionsPaginated(
        userId,
        skip: _skip,
        take: _take,
        search: _search,
      );

      _collectionsPaginatedModel = data;

      if (_collectionsModel?.metadata?.code == 200) {
        setLoading(false);

        return true;
      } else {
        setLoading(false);

        return false;
      }
    } catch (e) {
      log("Error load more collections: $e");
      setLoading(false);
      throw AppException(
          "Terjadi kesalahan saat memuat lebih banyak data. Silakan coba lagi.");
    }
  }

  void _onScroll() {
    log("scroll");
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
      if (_userId != null) {
        loadMoreCollections(_userId!);
      }
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
  
  Future<bool> deleteFromCollection(int historyId) async {
    try {
      setLoading(true);

      final data = await _collectionService.deleteFromCollection(historyId);

      _collectionModel = data;

      if (_collectionsModel?.metadata?.code == 200) {
        setLoading(false);

        return true;
      } else {
        setLoading(false);

        return false;
      }
    } catch (e) {
      log("Error delete from collection provider: $e");
      throw AppException(
          "Terjadi kesalahan saat memuat data. Silakan coba lagi.");
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }
}
