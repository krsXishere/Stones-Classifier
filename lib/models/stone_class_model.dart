class StoneClassModel {
  int? id;
  String? stoneClass, createdAt, updatedAt;

  StoneClassModel({
    required this.id,
    required this.stoneClass,
    required this.createdAt,
    required this.updatedAt,
  });

  factory StoneClassModel.fromJson(Map<String, dynamic> object) {
    return StoneClassModel(
      id: object['id'],
      stoneClass: object['class'],
      createdAt: object['createdAt'],
      updatedAt: object['updatedAt'],
    );
  }
}
