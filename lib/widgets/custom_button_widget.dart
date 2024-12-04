import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:stones_classifier/common/constant.dart';

class CustomButtonWidget extends StatelessWidget {
  final String text;
  final bool isLoading, isEnable, isAutoSize;
  final Function() onPressed;
  final Color color;

  const CustomButtonWidget({
    super.key,
    required this.text,
    required this.color,
    required this.isLoading,
    this.isEnable = true,
    this.isAutoSize = false,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return isAutoSize
        ? SizedBox(
            height: 50,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.all(5),
                surfaceTintColor: Colors.transparent,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                elevation: 0,
                backgroundColor:
                    isEnable == true ? color : color.withOpacity(0.5),
              ),
              onPressed: isEnable == true ? onPressed : () {},
              child: isLoading == true
                  ? CupertinoActivityIndicator(
                      color: white,
                    )
                  : Text(
                      text,
                      style: primaryTextStyle,
                    ),
            ),
          )
        : SizedBox(
            height: 50,
            width: double.maxFinite,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                surfaceTintColor: Colors.transparent,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                elevation: 0,
                backgroundColor:
                    isEnable == true ? color : color.withOpacity(0.5),
              ),
              onPressed: isEnable == true ? onPressed : () {},
              child: isLoading == true
                  ? CupertinoActivityIndicator(
                      color: white,
                    )
                  : Text(
                      text,
                      style: primaryTextStyle,
                    ),
            ),
          );
  }
}
