import 'package:stones_classifier/models/practitioner_model.dart';

class UserModel {
  int? id;
  String? name;
  String? email;
  String? phone;
  int? isGoogleAuth;
  String? createdAt;
  String? updatedAt;
  PractitionerModel? practitioner;

  UserModel({
    this.id,
    this.name,
    this.email,
    this.phone,
    this.isGoogleAuth,
    this.createdAt,
    this.updatedAt,
    this.practitioner,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      phone: json['phone'],
      isGoogleAuth: json['isGoogleAuth'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
      practitioner: json['practitioner'] != null
          ? PractitionerModel.fromJson(json['practitioner'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'phone': phone,
      'isGoogleAuth': isGoogleAuth,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
      'practitioner': practitioner?.toJson(),
    };
  }
}
