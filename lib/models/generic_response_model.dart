import 'dart:developer';

import '../common/exceptions/app_exception.dart';
import 'metadata_model.dart';

class GenericResponseModel<T> {
  Metadata? metadata;
  T? data;

  GenericResponseModel({
    required this.metadata,
    required this.data,
  });

  factory GenericResponseModel.fromJson(
    Map<String, dynamic> json,
    T Function(dynamic) fromJsonT,
  ) {
    try {
      return GenericResponseModel(
        metadata: Metadata.fromJson(json['metadata']),
        data: fromJsonT(json['data']),
      );
    } catch (e) {
      log("Error generic response model: $e");
      throw AppException("Gagal memparsing response: $e");
    }
  }

  Map<String, dynamic> toJson(Map<String, dynamic> Function(T?) toJsonT) {
    return {
      'metadata': metadata?.toJson(),
      'data': toJsonT(data),
    };
  }
}
