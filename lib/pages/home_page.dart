import 'package:flutter/material.dart';
import 'package:stones_classifier/common/constant.dart';
import 'package:stones_classifier/widgets/card_history_section_widget.dart';
import 'package:stones_classifier/widgets/list_tile_literacy_section_widget.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(defaultPadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Text(
                  "STONES CLASSIFIER",
                  style: primaryTextStyle.copyWith(
                    fontSize: 30,
                    color: primaryColor,
                    fontWeight: extraBold,
                  ),
                ),
              ),
              SizedBox(
                height: defaultPadding,
              ),
              Center(
                child: Container(
                  padding: EdgeInsets.all(defaultPadding),
                  width: double.maxFinite,
                  decoration: BoxDecoration(
                    color: primaryColor,
                    borderRadius: BorderRadius.circular(defaultBorderRadius),
                  ),
                  child: Column(
                    children: [
                      Icon(
                        Icons.camera_alt_rounded,
                        color: white,
                        size: 30,
                      ),
                      Text(
                        "Identifikasi",
                        style: primaryTextStyle.copyWith(
                          fontSize: 18,
                          fontWeight: bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: defaultPadding,
              ),
              Text(
                "Riwayat",
                style: secondaryTextStyle.copyWith(
                  fontWeight: bold,
                ),
              ),
              SizedBox(
                height: defaultPadding,
              ),
              const CardHistorySectionWidget(),
              SizedBox(
                height: defaultPadding,
              ),
              Text(
                "Literasi",
                style: secondaryTextStyle.copyWith(
                  fontWeight: bold,
                ),
              ),
              SizedBox(
                height: defaultPadding,
              ),
              const ListTileLiteracySectionWidget(),
            ],
          ),
        ),
      ),
    );
  }
}
