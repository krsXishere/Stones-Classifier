import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stones_classifier/common/constant.dart';
import 'package:stones_classifier/models/history_model.dart';
import 'package:stones_classifier/providers/collection_provider.dart';
import 'package:stones_classifier/providers/history_provider.dart';
import 'package:stones_classifier/providers/user_provider.dart';
import 'package:stones_classifier/widgets/custom_button_widget.dart';
import 'package:stones_classifier/widgets/modal_bottom_sheet_widget.dart';

class StoneHistoryPage extends StatelessWidget {
  const StoneHistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    saveToCollectionModal(
      UserProvider userProvider,
      CollectionProvider collectionProvider,
      int historyId,
      int isCollected,
      String predictedClass,
      String imageUrl,
    ) {
      showModal(
        context,
        [
          Center(
            child: Text(
              isCollected == 0 ? "Simpan Koleksi?" : "Tersimpan di Koleksi",
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
              child: Image.network(
                imageUrl,
                fit: BoxFit.cover,
              ),
            ),
          ),
          SizedBox(
            height: defaultPadding,
          ),
          isCollected == 0
              ? Row(
                  children: [
                    Expanded(
                      child: CustomButtonWidget(
                        text: "Batal",
                        color: Colors.red,
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                    ),
                    SizedBox(
                      width: defaultPadding,
                    ),
                    Expanded(
                      child: CustomButtonWidget(
                        text: "Simpan",
                        color: primaryColor,
                        isLoading: collectionProvider.isLoading,
                        onPressed: () async {
                          await collectionProvider.saveToCollection(historyId);
                          await collectionProvider.getCollection();

                          if (context.mounted) {
                            Navigator.of(context).pop();
                          }
                        },
                      ),
                    ),
                  ],
                )
              : const SizedBox.shrink(),
        ],
      );
    }

    return Scaffold(
      backgroundColor: white,
      body: Consumer3<HistoryProvider, CollectionProvider, UserProvider>(
        builder: (context, historyProvider, collectionProvider, userProvider,
            child) {
          return historyProvider.isLoading
              ? const Center(
                  child: CupertinoActivityIndicator(),
                )
              : ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: historyProvider.historiesModel?.data.length ?? 0,
                  itemBuilder: (context, index) {
                    final histories = historyProvider.historiesModel?.data
                        as List<HistoryModel>?;

                    if (histories == null || histories.isEmpty) {
                      return const Center(child: Text("Tidak ada data"));
                    }

                    final history = histories[index];

                    return GestureDetector(
                      onTap: () {
                        saveToCollectionModal(
                          userProvider,
                          collectionProvider,
                          history.id ?? 0,
                          history.isCollected ?? 0,
                          history.stoneClassModel?.stoneClass ?? "",
                          "${history.image}",
                        );
                      },
                      child: Container(
                        padding: const EdgeInsets.all(10),
                        margin: const EdgeInsets.only(bottom: 10),
                        width: double.maxFinite,
                        decoration: BoxDecoration(
                          color: primaryColor,
                          borderRadius:
                              BorderRadius.circular(defaultBorderRadius),
                        ),
                        child: Row(
                          children: [
                            Container(
                              height: 50,
                              width: 50,
                              decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.circular(defaultBorderRadius),
                                color: Colors.white,
                              ),
                              child: history.image != null
                                  ? ClipRRect(
                                      borderRadius: BorderRadius.circular(
                                          defaultBorderRadius),
                                      child: Image.network(
                                        "${history.image}",
                                        fit: BoxFit.cover,
                                      ),
                                    )
                                  : Icon(
                                      Icons.image_not_supported_rounded,
                                      color: black1,
                                    ),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Text(
                              history.stoneClassModel?.stoneClass ?? "",
                              style: primaryTextStyle,
                            ),
                            const Spacer(),
                            Text(
                              formatTime(
                                true,
                                date: DateTime.parse(
                                  history.createdAt.toString(),
                                ),
                              ),
                              style: primaryTextStyle,
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
        },
      ),
    );
  }
}
