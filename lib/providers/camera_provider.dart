import 'dart:developer';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:stones_classifier/main.dart';

class CameraProvider with ChangeNotifier {
  CameraController? _cameraController;
  CameraController? get cameraController => _cameraController;
  XFile? _currentImage;
  XFile? get currentImage => _currentImage;

  void initCamera() {
    _cameraController = CameraController(
      cameras[0],
      ResolutionPreset.low,
    );
    if (_cameraController != null) {
      _cameraController!.initialize().then((_) {
        notifyListeners();
      }).catchError((e) {
        if (e is CameraException) {
          switch (e.code) {
            case 'CameraAccessDenied':
              // Handle access errors here.
              break;
            default:
              // Handle other errors here.
              break;
          }
        }
      });
    }
  }

  Future<XFile?> takePicture() async {
    if (_cameraController != null) {
      if (!_cameraController!.value.isTakingPicture) {
        try {
          final XFile image = await _cameraController!.takePicture();

          return _currentImage = image;
        } on CameraException catch (e) {
          _showCameraException(e);
          return null;
        }
      } else {
        log("Kamera sedang memotret");
        return null;
      }
    } else {
      log("Kamera null");
      return null;
    }
  }

  void _showCameraException(CameraException e) {
    log("${e.code}\n${e.description}");
  }

  @override
  void dispose() {
    if (_cameraController != null) {
      _cameraController!.dispose();
      _cameraController = null;
    }
    super.dispose();
  }
}
