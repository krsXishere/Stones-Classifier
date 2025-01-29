import 'package:flutter/material.dart';
import 'package:stones_classifier/common/constant.dart';
import 'package:stones_classifier/pages/stone_collection_page.dart';
import 'package:stones_classifier/pages/stone_history_page.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage>
    with TickerProviderStateMixin {
  TextEditingController searchController = TextEditingController();
  late TabController _tabController;

  @override
  void initState() {
    _tabController = TabController(
      initialIndex: 0,
      length: 2,
      vsync: this,
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(defaultPadding),
          child: Column(
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
              Row(
                children: [
                  Container(
                    height: 70,
                    width: 70,
                    decoration: BoxDecoration(
                        borderRadius:
                            BorderRadius.circular(defaultBorderRadius),
                        border: Border.all(),
                        color: Colors.transparent),
                    child: Icon(
                      Icons.person,
                      color: black1,
                    ),
                  ),
                  SizedBox(
                    width: defaultPadding,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Krisna Purnama",
                        style: secondaryTextStyle.copyWith(
                          fontSize: 18,
                          fontWeight: bold,
                        ),
                      ),
                      Text(
                        "Akses Gratis",
                        style: secondaryTextStyle.copyWith(
                          fontSize: 16,
                          color: primaryColor,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(
                height: defaultPadding,
              ),
              // CustomTextFormFieldWidget(
              //   hintText: "Cari...",
              //   isPasswordField: false,
              //   isItalicHint: true,
              //   controller: searchController,
              //   type: TextInputType.text,
              //   onTap: () {},
              // ),
              SizedBox(
                height: defaultPadding,
              ),
              TabBar(
                controller: _tabController,
                labelColor: primaryColor,
                labelStyle: primaryTextStyle,
                indicatorColor: primaryColor,
                overlayColor: WidgetStatePropertyAll(
                  primaryColor.withOpacity(0.2),
                ),
                dividerColor: black1,
                tabs: const [
                  Tab(
                    child: Center(
                      child: Text(
                        "Koleksi\n0",
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                  Tab(
                    child: Center(
                      child: Text(
                        "Riwayat\n0",
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: defaultPadding,
              ),
              SizedBox(
                height: height(context) * 0.4,
                child: TabBarView(
                  controller: _tabController,
                  children: const [
                    StoneCollectionPage(),
                    StoneHistoryPage(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
