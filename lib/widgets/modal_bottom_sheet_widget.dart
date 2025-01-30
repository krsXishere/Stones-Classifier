import 'package:flutter/material.dart';
import 'package:stones_classifier/common/constant.dart';

showModal(
  BuildContext context,
  List<Widget> content, {
  int? index,
  bool isScrollControlled = false,
}) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: isScrollControlled,
    builder: (context) {
      return Wrap(
        children: [
          Container(
            padding: EdgeInsets.all(defaultPadding),
            width: width(context),
            decoration: BoxDecoration(
              color: white,
              borderRadius: BorderRadius.vertical(
                top: Radius.circular(defaultBorderRadius),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Container(
                    margin: EdgeInsets.only(bottom: defaultPadding),
                    height: 10,
                    width: 50,
                    decoration: BoxDecoration(
                      color: primaryColor,
                      borderRadius: BorderRadius.circular(defaultBorderRadius),
                    ),
                  ),
                ),
                ...content,
              ],
            ),
          ),
        ],
      );
    },
  );
}
