import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:http/http.dart';
import 'package:stones_classifier/common/constant.dart';
import 'package:stones_classifier/common/exceptions/app_exception.dart';
import 'package:stones_classifier/models/generic_response_model.dart';
import 'package:stones_classifier/models/user_model.dart';
import 'package:path/path.dart' as path;

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

  Future<GenericResponseModel<UserModel>?> changeProfilePicture(
      FilePickerResult? image) async {
    try {
      String? email = await storage.read(key: "email");
      String? token = await storage.read(key: "token");
      Uri apiUrl =
          Uri.parse("${baseApiUrl()}/user/change-profile-picture/$email");

      var request = MultipartRequest(
        "POST",
        apiUrl,
      );

      request.headers.addAll({
        'Authorization': "Bearer $token",
        'Accept': 'application/json',
        'Content-Type': 'multipart/form-data',
      });

      if (image != null) {
        File file = File(image.files.single.path!);
        var stream = ByteStream(file.openRead());
        stream.cast();
        var length = await file.length();

        request.files.add(
          MultipartFile(
            "file",
            stream,
            length,
            filename: path.basename(file.path),
          ),
        );
      }

      Response response = await Response.fromStream(
        await request.send(),
      );

      var jsonObject = jsonDecode(response.body);

      return GenericResponseModel.fromJson(
        jsonObject,
        (data) => UserModel.fromJson(data),
      );
    } catch (e) {
      log("Error change profile picture service: $e");
      throw AppException("Terjadi kesalahan saat memuat. Silakan coba lagi.");
    }
  }
}
