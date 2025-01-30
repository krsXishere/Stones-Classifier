import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stones_classifier/common/constant.dart';
import 'package:stones_classifier/providers/collection_provider.dart';

class StoneCollectionPage extends StatelessWidget {
  const StoneCollectionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
      body: Consumer<CollectionProvider>(
        builder: (context, collectionProvider, child) {
          return ListView.builder(
            itemCount: collectionProvider.collectionsModel?.data?.length ?? 0,
            itemBuilder: (context, index) {
              final collections = collectionProvider.collectionsModel?.data;

              if (collections == null || collections.isEmpty) {
                return const Center(child: Text("Tidak ada data"));
              }

              final collection = collections[index];

              return Container(
                padding: const EdgeInsets.all(10),
                margin: const EdgeInsets.only(bottom: 10),
                width: double.maxFinite,
                decoration: BoxDecoration(
                  color: primaryColor,
                  borderRadius: BorderRadius.circular(defaultBorderRadius),
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
                              borderRadius:
                                  BorderRadius.circular(defaultBorderRadius),
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
              );
            },
          );
        },
      ),
    );
  }
}
