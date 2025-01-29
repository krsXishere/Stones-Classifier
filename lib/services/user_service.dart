import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart';
import 'package:stones_classifier/common/constant.dart';
import 'package:stones_classifier/common/exceptions/app_exception.dart';
import 'package:stones_classifier/models/generic_response_model.dart';
import 'package:stones_classifier/models/user_model.dart';

class UserService {
  Future<GenericResponseModel?> getProfileUser() async {
    try {
      String? email = await storage.read(key: "email");
      String? token = await storage.read(key: "token");
      Uri apiUrl = Uri.parse("${baseApiUrl()}/user/get-profile/$email");

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
        (data) => UserModel.fromJson(data),
      );
    } catch (e) {
      log("Error get profile service: $e");
      throw AppException("Terjadi kesalahan saat memuat. Silakan coba lagi.");
    }
  }
}
