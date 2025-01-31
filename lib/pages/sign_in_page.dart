import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:stones_classifier/common/constant.dart';
import 'package:stones_classifier/pages/request_otp_page.dart';
import 'package:stones_classifier/providers/authentication_provider.dart';
import 'package:stones_classifier/widgets/bottom_navigation_bar_widget.dart';
import 'package:stones_classifier/widgets/custom_button_widget.dart';
import 'package:stones_classifier/widgets/custom_text_form_field_widget.dart';
import 'package:stones_classifier/widgets/snackbar_widget.dart';
import '../common/exceptions/app_exception.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  void navigate() {
    Navigator.of(context).pushAndRemoveUntil(
      PageTransition(
        child: const BottomNavigationBarWidget(),
        type: PageTransitionType.rightToLeft,
      ),
      (Route<dynamic> route) => false,
    );
  }

  guardedSnackbar(
    String message,
    Color color,
  ) {
    showSnackBar(
      context,
      message,
      color,
    );
  }

  void signIn(
    AuthenticationProvider authenticationProvider,
    String email,
    String password,
  ) async {
    try {
      if (email.isNotEmpty && password.isNotEmpty) {
        if (await authenticationProvider.signIn(
          email,
          password,
        )) {
          navigate();
        } else {
          guardedSnackbar(
            "${authenticationProvider.authenticationModel?.genericResponseModel?.metadata?.message}",
            Colors.red,
          );
        }
      } else {
        guardedSnackbar(
          "Isi semua data.",
          Colors.red,
        );
      }
    } on AppException catch (e) {
      guardedSnackbar(
        e.message,
        Colors.red,
      );
    } catch (e) {
      guardedSnackbar(
        "$e",
        Colors.red,
      );
    }
  }

  void signInWithGoogle(AuthenticationProvider authenticationProvider) async {
    try {
      if (await authenticationProvider.signInWithGoogle()) {
        navigate();
      } else {
        guardedSnackbar(
          "${authenticationProvider.authenticationModel?.genericResponseModel?.metadata?.message}",
          Colors.red,
        );
      }
    } on AppException catch (e) {
      guardedSnackbar(
        e.message,
        Colors.red,
      );
    } catch (e) {
      guardedSnackbar(
        "$e",
        Colors.red,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
      body: SafeArea(
        child: Stack(
          children: [
            Padding(
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
                  const SizedBox(
                    height: 130,
                  ),
                  Container(
                    height: 50,
                    width: width(context) * 0.8,
                    decoration: BoxDecoration(
                      color: primaryColor,
                      borderRadius: const BorderRadius.vertical(
                        top: Radius.circular(40),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                height: height(context) * 0.7,
                width: double.maxFinite,
                decoration: const BoxDecoration(
                  color: Color(0xfff8f4f4),
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(40),
                  ),
                ),
                child: SingleChildScrollView(
                  padding: EdgeInsets.all(defaultPadding),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        "Masuk",
                        style: secondaryTextStyle.copyWith(
                          fontSize: 18,
                          fontWeight: bold,
                        ),
                      ),
                      SizedBox(
                        height: defaultPadding,
                      ),
                      Consumer<AuthenticationProvider>(
                        builder: (context, authenticationProvider, child) {
                          return ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              fixedSize: const Size(double.maxFinite, 50),
                              side: BorderSide(color: black1),
                              backgroundColor: white,
                            ),
                            onPressed: () {
                              signInWithGoogle(authenticationProvider);
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SizedBox(
                                  height: 25,
                                  width: 25,
                                  child: Image.asset(
                                    "assets/png/google.png",
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                SizedBox(
                                  width: defaultPadding,
                                ),
                                Text(
                                  "Masuk melalui Google",
                                  style: secondaryTextStyle,
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                      SizedBox(
                        height: defaultPadding,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            width: width(context) * 0.3,
                            child: Divider(
                              color: primaryColor,
                              thickness: 2,
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Text(
                            "atau",
                            style: secondaryTextStyle.copyWith(fontSize: 16),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          SizedBox(
                            width: width(context) * 0.3,
                            child: Divider(
                              color: primaryColor,
                              thickness: 2,
                            ),
                          )
                        ],
                      ),
                      SizedBox(
                        height: defaultPadding,
                      ),
                      CustomTextFormFieldWidget(
                        hintText: "Alamat email",
                        controller: emailController,
                        isFilled: true,
                      ),
                      SizedBox(
                        height: defaultPadding,
                      ),
                      Consumer<AuthenticationProvider>(
                        builder: (context, authenticationProvider, child) {
                          return CustomTextFormFieldWidget(
                            hintText: "Kata sandi",
                            controller: passwordController,
                            isPasswordField: true,
                            isFilled: true,
                            isObscureText: authenticationProvider.isObscureText,
                            setObscureText: () {
                              authenticationProvider.setObscureText();
                            },
                          );
                        },
                      ),
                      SizedBox(
                        height: defaultPadding,
                      ),
                      Consumer<AuthenticationProvider>(
                        builder: (context, authenticationProvider, child) {
                          return CustomButtonWidget(
                            text: "Masuk",
                            color: primaryColor,
                            isLoading: authenticationProvider.isLoading,
                            onPressed: () {
                              signIn(
                                authenticationProvider,
                                emailController.text,
                                passwordController.text,
                              );
                            },
                          );
                        },
                      ),
                      SizedBox(
                        height: defaultPadding,
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(
                            PageTransition(
                              child: const RequestOtpPage(),
                              type: PageTransitionType.rightToLeft,
                            ),
                          );
                        },
                        child: Text(
                          "Lupa kata sandi?",
                          style: secondaryTextStyle,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
