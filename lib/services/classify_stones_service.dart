import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:http/http.dart';
import 'package:stones_classifier/common/constant.dart';
import 'package:stones_classifier/models/classify_stones_model.dart';
import 'package:path/path.dart' as path;

class ClassifyStonesService {
  Future<ClassifyStonesModel?> classify(XFile? stoneImage) async {
    try {
      if (stoneImage != null) {
        // Kompres gambar
        final compressedFile = await FlutterImageCompress.compressWithFile(
          stoneImage.path,
          quality: 75, // Atur kualitas (0-100)
          format: CompressFormat.jpeg,
        );

        if (compressedFile != null) {
          // Simpan file hasil kompres ke direktori sementara
          final tempFile = File('${stoneImage.path}_compressed.jpg');
          await tempFile.writeAsBytes(compressedFile);

          // Buat request Multipart
          var request = MultipartRequest(
            "POST",
            Uri.parse("${baseAPIURL()}/classify"),
          );

          request.headers.addAll({
            'Accept': 'application/json',
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

          if (response.statusCode == 200) {
            var jsonObject = jsonDecode(response.body);
            return ClassifyStonesModel.fromJson(jsonObject);
          } else {
            log("Server error: ${response.statusCode}");
          }
        }
      } else {
        log("Foto kosong");
      }
    } catch (e) {
      log("$e");
      throw Exception("Error dalam klasifikasi batuan");
    }

    return null;
  }
}
