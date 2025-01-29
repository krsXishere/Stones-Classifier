import 'package:stones_classifier/models/access_type_model.dart';

class PractitionerModel {
  int? id;
  String? profilePicture;
  int? accessTypeId;
  String? createdAt;
  String? updatedAt;
  AccessTypeModel? accessTypeModel;

  PractitionerModel({
    this.id,
    this.profilePicture,
    this.accessTypeId,
    this.createdAt,
    this.updatedAt,
    this.accessTypeModel,
  });

  factory PractitionerModel.fromJson(Map<String, dynamic> json) {
    return PractitionerModel(
      id: json['id'],
      profilePicture: json['profilePicture'],
      accessTypeId: json['accessTypeId'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
      accessTypeModel: json['accessType'] != null
          ? AccessTypeModel.fromJson(json['accessType'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'profilePicture': profilePicture,
      'accessTypeId': accessTypeId,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
    };
  }
}
