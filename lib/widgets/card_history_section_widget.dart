import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stones_classifier/common/constant.dart';
import 'package:stones_classifier/models/history_model.dart';
import 'package:stones_classifier/providers/history_provider.dart';

class CardHistorySectionWidget extends StatelessWidget {
  const CardHistorySectionWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<HistoryProvider>(
      builder: (context, historyProvider, child) {
        final histories =
            historyProvider.historiesModel?.data as List<HistoryModel>?;

        final historiesLength = histories?.length ?? 0;

        return historiesLength < 3
            ? Center(
                child: Text(
                  "Belum ada riwayat.",
                  style: secondaryTextStyle,
                ),
              )
            : Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Stack(
                    children: [
                      Container(
                        height: 150,
                        width: 100,
                        decoration: BoxDecoration(
                          color: Colors.red,
                          borderRadius:
                              BorderRadius.circular(defaultBorderRadius),
                        ),
                      ),
                      Positioned(
                        top: 1,
                        left: 1,
                        child: Container(
                          height: 100,
                          width: 98,
                          decoration: BoxDecoration(
                            color: white,
                            borderRadius: BorderRadius.vertical(
                              top: Radius.circular(defaultBorderRadius),
                            ),
                          ),
                          child: histories?[0].image != null
                              ? ClipRRect(
                                  borderRadius: BorderRadius.vertical(
                                    top: Radius.circular(defaultBorderRadius),
                                  ),
                                  child: Image.network(
                                    "${baseImageUrl()}${histories?[0].image}",
                                    fit: BoxFit.cover,
                                  ),
                                )
                              : Icon(
                                  Icons.image_not_supported_rounded,
                                  color: black1,
                                ),
                        ),
                      ),
                    ],
                  ),
                  Stack(
                    children: [
                      Container(
                        height: 150,
                        width: 100,
                        decoration: BoxDecoration(
                          color: const Color(0xff94943c),
                          borderRadius:
                              BorderRadius.circular(defaultBorderRadius),
                        ),
                      ),
                      Positioned(
                        top: 1,
                        left: 1,
                        child: Container(
                          height: 100,
                          width: 98,
                          decoration: BoxDecoration(
                            color: white,
                            borderRadius: BorderRadius.vertical(
                              top: Radius.circular(defaultBorderRadius),
                            ),
                          ),
                          child: histories?[1].image != null
                              ? ClipRRect(
                                  borderRadius: BorderRadius.vertical(
                                    top: Radius.circular(defaultBorderRadius),
                                  ),
                                  child: Image.network(
                                    "${baseImageUrl()}${histories?[1].image}",
                                    fit: BoxFit.cover,
                                  ),
                                )
                              : Icon(
                                  Icons.image_not_supported_rounded,
                                  color: black1,
                                ),
                        ),
                      ),
                    ],
                  ),
                  Stack(
                    children: [
                      Container(
                        height: 150,
                        width: 100,
                        decoration: BoxDecoration(
                          color: const Color(0xff000aff),
                          borderRadius:
                              BorderRadius.circular(defaultBorderRadius),
                        ),
                      ),
                      Positioned(
                        top: 1,
                        left: 1,
                        child: Container(
                          height: 100,
                          width: 98,
                          decoration: BoxDecoration(
                            color: white,
                            borderRadius: BorderRadius.vertical(
                              top: Radius.circular(defaultBorderRadius),
                            ),
                          ),
                          child: histories?[2].image != null
                              ? ClipRRect(
                                  borderRadius: BorderRadius.vertical(
                                    top: Radius.circular(defaultBorderRadius),
                                  ),
                                  child: Image.network(
                                    "${baseImageUrl()}${histories?[2].image}",
                                    fit: BoxFit.cover,
                                  ),
                                )
                              : Icon(
                                  Icons.image_not_supported_rounded,
                                  color: black1,
                                ),
                        ),
                      ),
                    ],
                  ),
                ],
              );
      },
    );
  }
}
