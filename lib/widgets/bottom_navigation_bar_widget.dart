import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stones_classifier/common/constant.dart';
import 'package:stones_classifier/providers/bottom_navigation_bar_provider.dart';

class BottomNavigationBarWidget extends StatefulWidget {
  const BottomNavigationBarWidget({super.key});

  @override
  State<BottomNavigationBarWidget> createState() =>
      _BottomNavigationBarWidgetState();
}

class _BottomNavigationBarWidgetState extends State<BottomNavigationBarWidget> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Consumer<BottomNavigationBarProvider>(
      builder: (context, bottomNavigationBarProvider, child) {
        return Scaffold(
          body: SafeArea(
            child: Stack(
              children: [
                bottomNavigationBarProvider.body(),
                Visibility(
                  visible: !isPotrait(context),
                  child: IconButton(
                    onPressed: () {
                      _scaffoldKey.currentState?.openDrawer();
                    },
                    icon: Icon(
                      Icons.menu_rounded,
                      color: white,
                    ),
                  ),
                ),
              ],
            ),
          ),
          bottomNavigationBar: ClipRRect(
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(defaultBorderRadius),
            ),
            child: BottomNavigationBar(
              backgroundColor: white,
              selectedItemColor: primaryColor,
              unselectedItemColor: grey400,
              selectedFontSize: 14,
              unselectedFontSize: 12,
              selectedLabelStyle:
                  primaryTextStyle.copyWith(color: primaryColor),
              unselectedLabelStyle: primaryTextStyle.copyWith(color: grey400),
              type: BottomNavigationBarType.fixed,
              currentIndex: bottomNavigationBarProvider.currentIndex,
              onTap: (value) {
                bottomNavigationBarProvider.setCurrentIndex(value);
              },
              items: [
                BottomNavigationBarItem(
                  label: "Beranda",
                  icon: Icon(
                    bottomNavigationBarProvider.currentIndex == 0
                        ? Icons.home_rounded
                        : Icons.home_outlined,
                  ),
                ),
                BottomNavigationBarItem(
                  label: "Identifikasi",
                  icon: Icon(
                    bottomNavigationBarProvider.currentIndex == 1
                        ? Icons.camera_alt_rounded
                        : Icons.camera_alt_outlined,
                  ),
                ),
                BottomNavigationBarItem(
                  label: "Profil",
                  icon: Icon(
                    bottomNavigationBarProvider.currentIndex == 2
                        ? Icons.person_rounded
                        : Icons.person_outlined,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
