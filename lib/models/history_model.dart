import 'package:stones_classifier/models/stone_class_model.dart';

class HistoryModel {
  int? id, isCollected, stoneClassId, practitionerId;
  String? createdAt, updatedAt;
  StoneClassModel? stoneClassModel;

  HistoryModel({
    required this.id,
    required this.isCollected,
    required this.stoneClassId,
    required this.practitionerId,
    required this.createdAt,
    required this.updatedAt,
    required this.stoneClassModel,
  });

  factory HistoryModel.fromJson(Map<String, dynamic> object) {
    return HistoryModel(
      id: object['id'],
      isCollected: object['isCollected'],
      stoneClassId: object['stoneClassId'],
      practitionerId: object['practitionerId'],
      createdAt: object['createdAt'],
      updatedAt: object['updatedAt'],
      stoneClassModel: StoneClassModel.fromJson(object['stoneClass']),
    );
  }
}
