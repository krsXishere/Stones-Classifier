import 'dart:developer';
import '../common/exceptions/app_exception.dart';
import 'metadata_model.dart';

class GenericResponseModel<T> {
  MetadataModel? metadata;
  T? data;

  GenericResponseModel({
    required this.metadata,
    required this.data,
  });

  factory GenericResponseModel.fromJson(
    Map<String, dynamic> json,
    T Function(dynamic)? fromJsonT,
  ) {
    try {
      return GenericResponseModel(
        metadata: MetadataModel.fromJson(json['metadata']),
        data: json['data'] != null && fromJsonT != null
            ? fromJsonT(json['data'])
            : null,
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
