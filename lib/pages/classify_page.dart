import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stones_classifier/common/constant.dart';
import 'package:stones_classifier/providers/camera_provider.dart';
import 'package:stones_classifier/providers/classify_stones_provider.dart';
import 'package:stones_classifier/widgets/modal_bottom_sheet_widget.dart';
import 'package:stones_classifier/widgets/snackbar_widget.dart';

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

    showClassifyModal(String predictedClass) {
      showModal(
        context,
        Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(
              child: Text(
                "Klasifikasi Berhasil",
                style: secondaryTextStyle,
              ),
            ),
            SizedBox(
              height: defaultPadding,
            ),
            Center(
              child: Text(
                predictedClass,
                style: secondaryTextStyle.copyWith(
                  fontWeight: semiBold,
                ),
              ),
            ),
            SizedBox(
              height: height(context) * 0.3,
            ),
          ],
        ),
      );
    }

    guardedSnackbar(
      String message,
      Color color,
    ) {
      showSnackBar(context, message, color);
    }

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
                    fontSize: 30,
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
              Consumer2<CameraProvider, ClassifyStonesProvider>(
                builder:
                    (context, cameraProvider, classifyStonesProvider, child) {
                  return GestureDetector(
                    onTap: () async {
                      // showClassifyModal("Test");
                      final image = await cameraProvider.takePicture();
                      if (image != null) {
                        await classifyStonesProvider.classify(image);

                        if (classifyStonesProvider.classifyStonesModel !=
                            null) {
                          showClassifyModal(classifyStonesProvider
                              .classifyStonesModel!.predictedClass!);
                        } else {
                          guardedSnackbar(
                            "Gagal",
                            Colors.red,
                          );
                        }
                      }
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
