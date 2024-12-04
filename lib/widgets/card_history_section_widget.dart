import 'package:flutter/material.dart';
import 'package:stones_classifier/common/constant.dart';

class CardHistorySectionWidget extends StatelessWidget {
  const CardHistorySectionWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Stack(
          children: [
            Container(
              height: 150,
              width: 100,
              decoration: BoxDecoration(
                color: Colors.red,
                borderRadius: BorderRadius.circular(defaultBorderRadius),
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
                borderRadius: BorderRadius.circular(defaultBorderRadius),
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
                borderRadius: BorderRadius.circular(defaultBorderRadius),
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
              ),
            ),
          ],
        ),
      ],
    );
  }
}
