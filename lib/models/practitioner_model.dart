class PractitionerModel {
  int? id;
  String? profilePicture;
  int? accessTypeId;
  String? createdAt;
  String? updatedAt;

  PractitionerModel({
    this.id,
    this.profilePicture,
    this.accessTypeId,
    this.createdAt,
    this.updatedAt,
  });

  factory PractitionerModel.fromJson(Map<String, dynamic> json) {
    return PractitionerModel(
      id: json['id'],
      profilePicture: json['profilePicture'],
      accessTypeId: json['accessTypeId'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
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
