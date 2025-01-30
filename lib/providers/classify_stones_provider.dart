import 'dart:developer';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:stones_classifier/models/generic_response_model.dart';
import 'package:stones_classifier/services/classify_stones_service.dart';

class ClassifyStonesProvider with ChangeNotifier {
  final _classifyStonesService = ClassifyStonesService();
  GenericResponseModel? _classifyStonesModel;
  GenericResponseModel? get classifyStonesModel => _classifyStonesModel;

  Future<bool> classify(XFile? stoneImage) async {
    try {
      if (stoneImage != null) {
        log("foto tidak kosong");
        final data = await _classifyStonesService.classify(stoneImage);
        _classifyStonesModel = data;
      }

      return true;
    } catch (e) {
      return false;
    }
  }
}
