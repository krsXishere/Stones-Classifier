import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stones_classifier/common/constant.dart';
import 'package:stones_classifier/pages/stone_collection_page.dart';
import 'package:stones_classifier/pages/stone_history_page.dart';
import 'package:stones_classifier/providers/collection_provider.dart';
import 'package:stones_classifier/providers/history_provider.dart';
import 'package:stones_classifier/providers/user_provider.dart';
import 'package:stones_classifier/widgets/custom_text_form_field_widget.dart';

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
    void getData() async {
      final userProvider = Provider.of<UserProvider>(
        context,
        listen: false,
      );

      await userProvider.getProfileUser();

      if (context.mounted && userProvider.userModel?.data != null) {
        searchController.clear();

        Provider.of<CollectionProvider>(
          context,
          listen: false,
        ).setUserId(userProvider.userModel!.data!.id);

        Provider.of<HistoryProvider>(
          context,
          listen: false,
        ).setUserId(userProvider.userModel!.data!.id);

        Provider.of<HistoryProvider>(
          context,
          listen: false,
        ).setSearch(isClear: true);

        Provider.of<CollectionProvider>(
          context,
          listen: false,
        ).setSearch(isClear: true);

        Provider.of<HistoryProvider>(
          context,
          listen: false,
        ).getHistory();

        Provider.of<CollectionProvider>(
          context,
          listen: false,
        ).getCollection();
      }
    }

    WidgetsBinding.instance.addPostFrameCallback((timestamp) async {
      final userProvider = Provider.of<UserProvider>(
        context,
        listen: false,
      );

      if (userProvider.userModel?.data == null) {
        getData();
      }
    });

    return Scaffold(
      backgroundColor: white,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(defaultPadding),
          child: RefreshIndicator(
            color: primaryColor,
            onRefresh: () async {
              getData();
            },
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
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
                      Consumer<UserProvider>(
                        builder: (context, userProvider, child) {
                          return Container(
                            height: 70,
                            width: 70,
                            decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.circular(defaultBorderRadius),
                              border: Border.all(),
                              color: Colors.transparent,
                            ),
                            child: userProvider.userModel?.data?.practitioner
                                        ?.profilePicture !=
                                    null
                                ? ClipRRect(
                                    borderRadius: BorderRadius.circular(
                                        defaultBorderRadius),
                                    child: Image.network(
                                      "${userProvider.userModel?.data?.practitioner?.profilePicture}",
                                      fit: BoxFit.cover,
                                    ),
                                  )
                                : Icon(
                                    Icons.person,
                                    color: black1,
                                  ),
                          );
                        },
                      ),
                      SizedBox(
                        width: defaultPadding,
                      ),
                      Consumer<UserProvider>(
                        builder: (context, userProvider, child) {
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                userProvider.userModel?.data?.name ?? "",
                                style: secondaryTextStyle.copyWith(
                                  fontSize: 18,
                                  fontWeight: bold,
                                ),
                              ),
                              Text(
                                "${userProvider.userModel?.data?.practitioner?.accessTypeModel.access.toString() ?? ""} Akses",
                                style: secondaryTextStyle.copyWith(
                                  fontSize: 16,
                                  color: primaryColor,
                                ),
                              ),
                            ],
                          );
                        },
                      ),
                    ],
                  ),
                  SizedBox(
                    height: defaultPadding,
                  ),
                  Consumer2<CollectionProvider, HistoryProvider>(
                    builder:
                        (context, collectionProvider, historyProvider, child) {
                      return CustomTextFormFieldWidget(
                        hintText: "Cari",
                        controller: searchController,
                        isItalicHint: true,
                        suffixIcon: Icon(
                          Icons.search_rounded,
                          color: black1,
                        ),
                        onFieldSubmitted: (value) async {
                          if (_tabController.index == 0) {
                            await collectionProvider.setSearch(value: value);
                            await collectionProvider.getCollection();
                          } else {
                            await historyProvider.setSearch(value: value);
                            await historyProvider.getHistory();
                          }
                        },
                      );
                    },
                  ),
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
                    tabs: [
                      Tab(
                        child: Consumer<CollectionProvider>(
                          builder: (context, collectionProvider, child) {
                            return Text(
                              collectionProvider.collectionsModel?.data != null
                                  ? "Koleksi\n${collectionProvider.collectionsModel?.data?.length}"
                                  : "Koleksi\n0",
                              textAlign: TextAlign.center,
                            );
                          },
                        ),
                      ),
                      Tab(
                        child: Center(
                          child: Consumer<HistoryProvider>(
                            builder: (context, historyProvider, child) {
                              return Text(
                                historyProvider.historiesModel?.data != null
                                    ? "Riwayat\n${historyProvider.historiesModel?.data.length}"
                                    : "Riwayat\n0",
                                textAlign: TextAlign.center,
                              );
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: defaultPadding,
                  ),
                  SizedBox(
                    height: height(context) * 0.6,
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
        ),
      ),
    );
  }
}
