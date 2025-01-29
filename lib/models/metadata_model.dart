class MetadataModel {
  final int? code;
  final String? status;
  final String? message;

  MetadataModel({
    required this.code,
    required this.status,
    required this.message,
  });

  factory MetadataModel.fromJson(Map<String, dynamic> json) {
    return MetadataModel(
      code: json['code'],
      status: json['status'],
      message: json['message'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'code': code,
      'status': status,
      'message': message,
    };
  }
}
