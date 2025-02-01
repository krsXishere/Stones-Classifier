import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:stones_classifier/common/constant.dart';
import 'package:stones_classifier/pages/detail_literacy_page.dart';
import 'package:stones_classifier/providers/literacy_provider.dart';

class ListTileLiteracySectionWidget extends StatelessWidget {
  const ListTileLiteracySectionWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<LiteracyProvider>(
      builder: (context, literacyProvider, child) {
        final literacies = literacyProvider.literacies?.data;

        return literacyProvider.isLoading
            ? const Center(
                child: CupertinoActivityIndicator(),
              )
            : ListView.separated(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  final literacy = literacies?[index];

                  return GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(
                        PageTransition(
                          child: DetailLiteracyPage(
                            literacyId: literacy?.id ?? 0,
                          ),
                          type: PageTransitionType.rightToLeft,
                        ),
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
                            child: literacy?.image != null
                                ? ClipRRect(
                                    borderRadius: BorderRadius.circular(
                                        defaultBorderRadius),
                                    child: Image.network(
                                      "${baseImageUrl()}${literacy?.image}",
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
                            "${literacy?.stoneClassModel?.stoneClass}",
                            style: primaryTextStyle.copyWith(
                              fontSize: 18,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
                separatorBuilder: (context, index) {
                  return const SizedBox.shrink();
                },
                itemCount: literacyProvider.literacies?.data?.length ?? 0,
              );
      },
    );
  }
}
