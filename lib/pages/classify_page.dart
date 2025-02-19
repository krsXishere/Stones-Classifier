import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stones_classifier/common/constant.dart';
import 'package:stones_classifier/common/exceptions/app_exception.dart';
import 'package:stones_classifier/providers/camera_provider.dart';
import 'package:stones_classifier/providers/classify_stones_provider.dart';
import 'package:stones_classifier/widgets/custom_button_widget.dart';
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

    showClassifyModal(String predictedClass, XFile? image) {
      showModal(
        context,
        [
          Center(
            child: Text(
              "Identifikasi Berhasil",
              style: secondaryTextStyle.copyWith(
                fontWeight: bold,
              ),
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
            height: defaultPadding,
          ),
          ClipRRect(
            borderRadius: BorderRadius.circular(defaultBorderRadius),
            child: SizedBox(
              height: height(context) * 0.3,
              width: double.maxFinite,
              child: Image.file(
                File(image!.path),
                fit: BoxFit.cover,
              ),
            ),
          ),
          SizedBox(
            height: defaultPadding,
          ),
          CustomButtonWidget(
            text: "Kembali",
            color: primaryColor,
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
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
                      try {
                        final image = await cameraProvider.takePicture();

                        if (image != null) {
                          await classifyStonesProvider.classify(image);

                          if (classifyStonesProvider.classifyStonesModel !=
                              null) {
                            showClassifyModal(
                              classifyStonesProvider
                                  .classifyStonesModel!.data.predictedClass!,
                              image,
                            );
                          } else {
                            if (context.mounted) {
                              showSnackBar(
                                context,
                                "Gagal",
                                Colors.red,
                              );
                            }
                          }
                        }
                      } on AppException catch (e) {
                        guardedSnackbar(
                          e.message,
                          Colors.red,
                        );
                      } catch (e) {
                        guardedSnackbar(
                          "$e",
                          Colors.red,
                        );
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
