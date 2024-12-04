import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stones_classifier/common/constant.dart';
import 'package:stones_classifier/providers/camera_provider.dart';

class ClassifyPage extends StatelessWidget {
  const ClassifyPage({super.key});

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<CameraProvider>(
        context,
        listen: false,
      ).initCamera();
    });

    return Scaffold(
      backgroundColor: white,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(defaultPadding),
          child: Column(
            children: [
              Center(
                child: Text(
                  "STONES CLASSIFIER",
                  style: primaryTextStyle.copyWith(
                    fontSize: 35,
                    color: primaryColor,
                    fontWeight: extraBold,
                  ),
                ),
              ),
              SizedBox(
                height: defaultPadding,
              ),
              Container(
                height: height(context) * 0.65,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(defaultBorderRadius),
                  color: Colors.black,
                ),
                child: Consumer<CameraProvider>(
                  builder: (context, cameraProvider, child) {
                    return cameraProvider
                                .cameraController?.value.isInitialized ==
                            true
                        ? ClipRRect(
                            borderRadius:
                                BorderRadius.circular(defaultBorderRadius),
                            child:
                                CameraPreview(cameraProvider.cameraController!),
                          )
                        : const SizedBox.shrink();
                  },
                ),
              ),
              SizedBox(
                height: defaultPadding,
              ),
              Consumer<CameraProvider>(
                builder: (context, cameraProvider, child) {
                  return GestureDetector(
                    onTap: () {
                      cameraProvider.takePicture();
                    },
                    child: Container(
                      height: 70,
                      width: 70,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(),
                        color: Colors.grey[100],
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
