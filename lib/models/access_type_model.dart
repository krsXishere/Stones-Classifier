class AccessTypeModel {
  int? id;
  String? access, createdAt, updatedAt;

  AccessTypeModel({
    required this.id,
    required this.access,
    required this.createdAt,
    required this.updatedAt,
  });

  factory AccessTypeModel.fromJson(Map<String, dynamic> object) {
    return AccessTypeModel(
      id: object['id'],
      access: object['access'],
      createdAt: object['createdAt'],
      updatedAt: object['updatedAt'],
    );
  }
}
