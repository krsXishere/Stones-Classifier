import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart';
import 'package:stones_classifier/common/constant.dart';
import 'package:stones_classifier/common/exceptions/app_exception.dart';
import 'package:stones_classifier/models/generic_response_model.dart';
import 'package:stones_classifier/models/literacy_model.dart';

class LiteracyService {
  Future<GenericResponseModel<List<LiteracyModel>>?> getAllLiteracy() async {
    try {
      var token = await storage.read(key: "token");
      Uri apiUrl = Uri.parse("${baseApiUrl()}/literacy/get-all-literacy");
      var response = await get(
        apiUrl,
        headers: header(
          true,
          token: token,
        ),
      );

      var jsonObject = jsonDecode(response.body);

      return GenericResponseModel.fromJson(
        jsonObject,
        (data) => (data as List).map((e) => LiteracyModel.fromJson(e)).toList(),
      );
    } catch (e) {
      log("Error get all literacy service: $e");
      throw AppException(
          "Terjadi kesalahan saat mengambil data. Silakan coba lagi.");
    }
  }

  Future<GenericResponseModel<LiteracyModel>?> getLiteracy(
      int literacyId) async {
    try {
      var token = await storage.read(key: "token");
      Uri apiUrl =
          Uri.parse("${baseApiUrl()}/literacy/get-literacy/$literacyId");
      var response = await get(
        apiUrl,
        headers: header(
          true,
          token: token,
        ),
      );

      var jsonObject = jsonDecode(response.body);

      return GenericResponseModel.fromJson(
        jsonObject,
        (data) => LiteracyModel.fromJson(data),
      );
    } catch (e) {
      log("Error get literacy service: $e");
      throw AppException(
          "Terjadi kesalahan saat mengambil data. Silakan coba lagi.");
    }
  }
}
