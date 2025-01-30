import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart';
import 'package:stones_classifier/common/constant.dart';
import 'package:stones_classifier/common/exceptions/app_exception.dart';
import 'package:stones_classifier/models/generic_response_model.dart';
import 'package:stones_classifier/models/history_model.dart';

class HistoryService {
  Future<GenericResponseModel?> getHistory(
    int userId, {
    String? search,
  }) async {
    try {
      var token = await storage.read(key: "token");
      Uri apiUrl = Uri.parse(search == null
          ? "${baseApiUrl()}/history/get-all-history/$userId"
          : "${baseApiUrl()}/history/get-all-history/$userId/$search");
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
        (data) => (data as List).map((e) => HistoryModel.fromJson(e)).toList(),
      );
    } catch (e) {
      log("Error get history service: $e");
      throw AppException(
          "Terjadi kesalahan saat mengambil data. Silakan coba lagi.");
    }
  }
}
