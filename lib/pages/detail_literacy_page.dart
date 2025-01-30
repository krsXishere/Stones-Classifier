import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import 'package:stones_classifier/common/constant.dart';
import 'package:stones_classifier/providers/literacy_provider.dart';

class DetailLiteracyPage extends StatelessWidget {
  const DetailLiteracyPage({
    super.key,
    required this.literacyId,
  });

  final int literacyId;

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((timestamp) async {
      Provider.of<LiteracyProvider>(
        context,
        listen: false,
      ).getLiteracy(literacyId);
    });

    return Scaffold(
      appBar: AppBar(
        backgroundColor: white,
        centerTitle: true,
        automaticallyImplyLeading: false,
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: const Icon(
            Icons.arrow_back_ios_new_rounded,
            color: Colors.black,
          ),
        ),
        title: Consumer<LiteracyProvider>(
          builder: (context, literacyProvider, child) {
            return Text(
              "Literasi ${literacyProvider.literacy?.data?.stoneClassModel?.stoneClass}",
              style: secondaryTextStyle.copyWith(
                fontSize: 16,
                fontWeight: bold,
              ),
            );
          },
        ),
      ),
      backgroundColor: white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(defaultPadding),
          physics: const BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Consumer<LiteracyProvider>(
                builder: (context, literacyProvider, child) {
                  return literacyProvider.isLoading
                      ? ClipRRect(
                          borderRadius:
                              BorderRadius.circular(defaultBorderRadius),
                          child: SizedBox(
                            height: height(context) * 0.3,
                            width: width(context),
                            child: Shimmer.fromColors(
                              baseColor: Colors.grey,
                              highlightColor: white,
                              child: Container(
                                height: height(context) * 0.3,
                                width: width(context),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(
                                      defaultBorderRadius),
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        )
                      : Container(
                          height: height(context) * 0.3,
                          width: width(context),
                          decoration: BoxDecoration(
                            borderRadius:
                                BorderRadius.circular(defaultBorderRadius),
                            color: Colors.white,
                          ),
                          child: literacyProvider.literacy?.data?.image != null
                              ? ClipRRect(
                                  borderRadius: BorderRadius.circular(
                                      defaultBorderRadius),
                                  child: Image.network(
                                    "${literacyProvider.literacy?.data?.image}",
                                    fit: BoxFit.cover,
                                  ),
                                )
                              : Icon(
                                  Icons.image_not_supported_rounded,
                                  color: black1,
                                  size: 100,
                                ),
                        );
                },
              ),
              SizedBox(
                height: defaultPadding,
              ),
              Consumer<LiteracyProvider>(
                builder: (context, literacyProvider, child) {
                  return literacyProvider.isLoading
                      ? Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ClipRRect(
                              borderRadius:
                                  BorderRadius.circular(defaultBorderRadius),
                              child: SizedBox(
                                height: 15,
                                width: width(context),
                                child: Shimmer.fromColors(
                                  baseColor: Colors.grey,
                                  highlightColor: white,
                                  child: Container(
                                    height: 10,
                                    width: width(context),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(
                                          defaultBorderRadius),
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            ClipRRect(
                              borderRadius:
                                  BorderRadius.circular(defaultBorderRadius),
                              child: SizedBox(
                                height: 15,
                                width: width(context) * 0.8,
                                child: Shimmer.fromColors(
                                  baseColor: Colors.grey,
                                  highlightColor: white,
                                  child: Container(
                                    height: 10,
                                    width: width(context),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(
                                          defaultBorderRadius),
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                            )
                          ],
                        )
                      : Text(
                          "${literacyProvider.literacy?.data?.description}",
                          style: secondaryTextStyle.copyWith(
                            fontSize: 14,
                          ),
                          textAlign: TextAlign.justify,
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
