import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stones_classifier/common/constant.dart';
import 'package:stones_classifier/models/history_model.dart';
import 'package:stones_classifier/providers/history_provider.dart';

class StoneHistoryPage extends StatelessWidget {
  const StoneHistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
      body: Consumer<HistoryProvider>(
        builder: (context, historyProvider, child) {
          return ListView.builder(
            shrinkWrap: true,
            itemCount: historyProvider.historiesModel?.data.length ?? 0,
            itemBuilder: (context, index) {
              final histories =
                  historyProvider.historiesModel?.data as List<HistoryModel>?;

              if (histories == null || histories.isEmpty) {
                return const Center(child: Text("Tidak ada data"));
              }

              final history = histories[index];

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
                      child: history.image != null
                          ? ClipRRect(
                              borderRadius:
                                  BorderRadius.circular(defaultBorderRadius),
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
              );
            },
          );
        },
      ),
    );
  }
}
