import 'package:stones_classifier/models/stone_class_model.dart';

class LiteracyModel {
  int? id, stoneClassId;
  String? description, image, createdAt, updatedAt;
  StoneClassModel? stoneClassModel;

  LiteracyModel({
    required this.id,
    required this.description,
    required this.image,
    required this.stoneClassId,
    required this.createdAt,
    required this.updatedAt,
    required this.stoneClassModel,
  });

  factory LiteracyModel.fromJson(Map<String, dynamic> object) {
    return LiteracyModel(
      id: object['id'],
      description: object['description'],
      image: object['image'],
      stoneClassId: object['stoneClassId'],
      createdAt: object['createdAt'],
      updatedAt: object['updatedAt'],
      stoneClassModel: StoneClassModel.fromJson(object['stoneClass']),
    );
  }
}
