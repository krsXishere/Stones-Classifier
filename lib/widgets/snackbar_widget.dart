import 'package:flutter/material.dart';
import 'package:stones_classifier/common/constant.dart';

showSnackBar(
  BuildContext context,
  String message,
  Color color,
) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      backgroundColor: color,
      content: Text(
        message,
        style: primaryTextStyle.copyWith(
          color: white,
        ),
      ),
    ),
  );
}
