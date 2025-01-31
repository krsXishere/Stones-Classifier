import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:stones_classifier/common/constant.dart';
import 'package:stones_classifier/common/exceptions/app_exception.dart';
import 'package:stones_classifier/pages/sign_in_page.dart';
import 'package:stones_classifier/pages/stone_collection_page.dart';
import 'package:stones_classifier/pages/stone_history_page.dart';
import 'package:stones_classifier/providers/bottom_navigation_bar_provider.dart';
import 'package:stones_classifier/providers/collection_provider.dart';
import 'package:stones_classifier/providers/history_provider.dart';
import 'package:stones_classifier/providers/user_provider.dart';
import 'package:stones_classifier/widgets/custom_button_widget.dart';
import 'package:stones_classifier/widgets/custom_text_form_field_widget.dart';
import 'package:stones_classifier/widgets/modal_bottom_sheet_widget.dart';
import 'package:stones_classifier/widgets/snackbar_widget.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage>
    with TickerProviderStateMixin {
  TextEditingController searchController = TextEditingController();
  late TabController _tabController;

  Future<FilePickerResult?> pickImage() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: [
        'png',
        'jpg',
        'jpeg',
      ],
    );

    return result;
  }

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
    Future<PermissionStatus?> getStoragePermission() async {
      try {
        var status = await Permission.storage.status;

        if (status.isDenied) {
          final result = await Permission.storage.request();
          return result;
        } else {
          return status;
        }
      } on AppException catch (e) {
        if (context.mounted) {
          showSnackBar(
            context,
            e.message,
            Colors.red,
          );
        }
      } catch (e) {
        if (context.mounted) {
          showSnackBar(
            context,
            "$e",
            Colors.red,
          );
        }
      }
      return null;
    }

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
                          return Stack(
                            children: [
                              Container(
                                height: 70,
                                width: 70,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(
                                      defaultBorderRadius),
                                  border: Border.all(),
                                  color: Colors.transparent,
                                ),
                                child: userProvider.userModel?.data
                                            ?.practitioner?.profilePicture !=
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
                              ),
                              Positioned(
                                bottom: 0,
                                right: 0,
                                child: Consumer<UserProvider>(
                                  builder: (context, userProvider, child) {
                                    return GestureDetector(
                                      onTap: () async {
                                        await getStoragePermission();
                                        var result = await pickImage();
                                        await userProvider
                                            .changeProfilePicture(result);
                                        await userProvider.getProfileUser();
                                      },
                                      child: Container(
                                        padding: const EdgeInsets.all(4),
                                        decoration: const BoxDecoration(
                                          color: Colors.white,
                                          shape: BoxShape.circle,
                                        ),
                                        child: Icon(
                                          Icons.edit_rounded,
                                          color: black1,
                                          size: 16,
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ],
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
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.red,
        onPressed: () {
          showModal(
            context,
            [
              Center(
                child: Text(
                  "Keluar?",
                  style: secondaryTextStyle.copyWith(
                    fontWeight: bold,
                  ),
                ),
              ),
              SizedBox(
                height: defaultPadding,
              ),
              Center(
                child: Text(
                  "Data Anda aman! Jika keluar dari aplikasi, semua informasi dan progress Anda akan tersimpan otomatis. Anda bisa melanjutkan dari tempat terakhir kali kapan pun Anda kembali.",
                  style: secondaryTextStyle,
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(
                height: defaultPadding,
              ),
              Row(
                children: [
                  Expanded(
                    child: Consumer<BottomNavigationBarProvider>(
                      builder: (context, bottomNavigationBarProvider, child) {
                        return CustomButtonWidget(
                          text: "Keluar",
                          color: Colors.red,
                          onPressed: () async {
                            await storage.deleteAll();

                            if (context.mounted) {
                              Navigator.of(context).pushAndRemoveUntil(
                                PageTransition(
                                  child: const SignInPage(),
                                  type: PageTransitionType.rightToLeft,
                                ),
                                (Route<dynamic> route) => false,
                              );
                            }

                            await bottomNavigationBarProvider
                                .setCurrentIndex(0);
                          },
                        );
                      },
                    ),
                  ),
                  SizedBox(
                    width: defaultPadding,
                  ),
                  Expanded(
                    child: CustomButtonWidget(
                      text: "Batal",
                      color: primaryColor,
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                  ),
                ],
              )
            ],
          );
        },
        tooltip: "Keluar",
        child: Icon(
          Icons.logout_rounded,
          color: white,
        ),
      ),
    );
  }
}
