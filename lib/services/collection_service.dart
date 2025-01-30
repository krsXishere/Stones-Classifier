import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart';
import 'package:stones_classifier/common/constant.dart';
import 'package:stones_classifier/common/exceptions/app_exception.dart';
import 'package:stones_classifier/models/collection_model.dart';
import 'package:stones_classifier/models/generic_response_model.dart';

class CollectionService {
  Future<GenericResponseModel<List<CollectionModel>>?> getCollection(
      int userId) async {
    try {
      var token = await storage.read(key: "token");
      Uri apiUrl =
          Uri.parse("${baseApiUrl()}/collection/get-all-collection/$userId");
      var response = await get(
        apiUrl,
        headers: header(true, token: token),
      );

      var jsonObject = jsonDecode(response.body);

      return GenericResponseModel.fromJson(
        jsonObject,
        (data) =>
            (data as List).map((e) => CollectionModel.fromJson(e)).toList(),
      );
    } catch (e) {
      log("Error get collection service: $e");
      throw AppException(
          "Terjadi kesalahan saat mengambil data. Silakan coba lagi.");
    }
  }

  Future<GenericResponseModel?> saveToCollection(int historyId) async {
    try {
      var token = await storage.read(key: "token");
      Uri apiUrl =
          Uri.parse("${baseApiUrl()}/collection/save-to-collection/$historyId");
      var response = await post(
        apiUrl,
        headers: header(
          true,
          token: token,
        ),
      );

      var jsonObject = jsonDecode(response.body);

      return GenericResponseModel.fromJson(
        jsonObject,
        (data) => CollectionModel.fromJson(data),
      );
    } catch (e) {
      log("Error save to collection service: $e");
      throw AppException(
          "Terjadi kesalahan saat memuat data. Silakan coba lagi.");
    }
  }
}
