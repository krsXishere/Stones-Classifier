class ClassifyStonesModel {
  String? fileName, predictedClass, confidenceLevel;

  ClassifyStonesModel({
    required this.fileName,
    required this.predictedClass,
    required this.confidenceLevel,
  });

  factory ClassifyStonesModel.fromJson(Map<String, dynamic> object) {
    return ClassifyStonesModel(
      fileName: object['filename'].toString(),
      predictedClass: object['predicted_class'].toString(),
      confidenceLevel: double.parse(object['confidence_level'].toString())
          .round()
          .toString(),
    );
  }
}
