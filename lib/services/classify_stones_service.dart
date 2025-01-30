import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:http/http.dart';
import 'package:stones_classifier/common/constant.dart';
import 'package:stones_classifier/common/exceptions/app_exception.dart';
import 'package:stones_classifier/models/classify_stones_model.dart';
import 'package:path/path.dart' as path;
import 'package:stones_classifier/models/generic_response_model.dart';

class ClassifyStonesService {
  Future<GenericResponseModel<ClassifyStonesModel>?> classify(
      XFile? stoneImage) async {
    try {
      var email = await storage.read(key: "email");
      var token = await storage.read(key: "token");

      final compressedFile = await FlutterImageCompress.compressWithFile(
        stoneImage!.path,
        quality: 75,
        format: CompressFormat.jpeg,
      );

      if (compressedFile != null) {
        final tempFile = File('${stoneImage.path}_compressed.jpg');
        await tempFile.writeAsBytes(compressedFile);

        var request = MultipartRequest(
          "POST",
          Uri.parse("${baseApiUrl()}/classify/$email"),
        );

        request.headers.addAll({
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
          'Content-Type': 'multipart/form-data',
        });

        var stream = ByteStream(tempFile.openRead());
        var length = await tempFile.length();
        String fileName = path.basename(tempFile.path);

        request.files.add(
          MultipartFile(
            'file',
            stream,
            length,
            filename: fileName,
          ),
        );

        Response response = await Response.fromStream(await request.send());

        var jsonObject = jsonDecode(response.body);

        log(jsonObject.toString());

        return GenericResponseModel.fromJson(
          jsonObject,
          (data) => ClassifyStonesModel.fromJson(data),
        );
      }
    } catch (e) {
      log("$e");
      throw AppException(
          "Terjadi kesalahan saat memuat data. Silakan coba lagi.");
    }

    return null;
  }
}
