import 'package:stones_classifier/models/stone_class_model.dart';

class CollectionModel {
  int? id, isCollected, stoneClassId, practitionerId;
  String? image, createdAt, updatedAt;
  StoneClassModel? stoneClassModel;

  CollectionModel({
    required this.id,
    required this.image,
    required this.isCollected,
    required this.stoneClassId,
    required this.practitionerId,
    required this.createdAt,
    required this.updatedAt,
    required this.stoneClassModel,
  });

  factory CollectionModel.fromJson(Map<String, dynamic> object) {
    return CollectionModel(
      id: object['id'],
      image: object['image'],
      isCollected: object['isCollected'],
      stoneClassId: object['stoneClassId'],
      practitionerId: object['practitionerId'],
      createdAt: object['createdAt'],
      updatedAt: object['updatedAt'],
      stoneClassModel: StoneClassModel.fromJson(object['stoneClass']),
    );
  }
}