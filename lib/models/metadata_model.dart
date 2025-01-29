class Metadata {
  final int? code;
  final String? status;
  final String? message;

  Metadata({
    required this.code,
    required this.status,
    required this.message,
  });

  factory Metadata.fromJson(Map<String, dynamic> json) {
    return Metadata(
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
