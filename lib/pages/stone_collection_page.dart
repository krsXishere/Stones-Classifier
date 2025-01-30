import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stones_classifier/common/constant.dart';
import 'package:stones_classifier/providers/collection_provider.dart';
import 'package:stones_classifier/widgets/custom_button_widget.dart';
import 'package:stones_classifier/widgets/modal_bottom_sheet_widget.dart';

class StoneCollectionPage extends StatelessWidget {
  const StoneCollectionPage({super.key});

  @override
  Widget build(BuildContext context) {
    deleteFromCollection(
      CollectionProvider collectionProvider,
      int historyId,
      String predictedClass,
      String imageUrl,
    ) {
      showModal(
        context,
        [
          Center(
            child: Text(
              "Hapus Koleksi?",
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
          Row(
            children: [
              Expanded(
                child: CustomButtonWidget(
                  text: "Hapus",
                  color: Colors.red,
                  isLoading: collectionProvider.isLoading,
                  onPressed: () async {
                    await collectionProvider.deleteFromCollection(historyId);
                    await collectionProvider.getCollection();

                    if (context.mounted) {
                      Navigator.of(context).pop();
                    }
                  },
                ),
              ),
              SizedBox(
                width: defaultPadding,
              ),
              Expanded(
                child: CustomButtonWidget(
                  text: "Batal",
                  color: primaryColor,
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ),
            ],
          ),
        ],
      );
    }

    return Scaffold(
      backgroundColor: white,
      body: Consumer<CollectionProvider>(
        builder: (context, collectionProvider, child) {
          return collectionProvider.isLoading
              ? const Center(
                  child: CupertinoActivityIndicator(),
                )
              : ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount:
                      collectionProvider.collectionsModel?.data?.length ?? 0,
                  itemBuilder: (context, index) {
                    final collections =
                        collectionProvider.collectionsModel?.data;

                    if (collections == null || collections.isEmpty) {
                      return const Center(child: Text("Tidak ada data"));
                    }

                    final collection = collections[index];

                    return GestureDetector(
                      onTap: () {
                        deleteFromCollection(
                          collectionProvider,
                          collection.id ?? 0,
                          collection.stoneClassModel?.stoneClass ?? "",
                          collection.image ?? "",
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
                              child: collection.image != null
                                  ? ClipRRect(
                                      borderRadius: BorderRadius.circular(
                                          defaultBorderRadius),
                                      child: Image.network(
                                        "${collection.image}",
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
                              collection.stoneClassModel?.stoneClass ?? "",
                              style: primaryTextStyle,
                            ),
                            const Spacer(),
                            Text(
                              formatTime(
                                true,
                                date: DateTime.parse(
                                  collection.createdAt.toString(),
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
