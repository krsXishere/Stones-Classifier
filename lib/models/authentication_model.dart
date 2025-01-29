import 'dart:developer';
import 'package:stones_classifier/models/generic_response_model.dart';
import '../common/exceptions/app_exception.dart';

class AuthenticationModel {
  GenericResponseModel<String>? genericResponseModel;

  AuthenticationModel({
    required this.genericResponseModel,
  });

  factory AuthenticationModel.fromJson(Map<String, dynamic> json) {
    try {
      return AuthenticationModel(
        genericResponseModel: GenericResponseModel.fromJson(
          json,
          (data) => data as String,
        ),
      );
    } catch (e) {
      log("Error authentication model: $e");
      throw AppException("Gagal memparsing authentication response: $e");
    }
  }
}
