import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:stones_classifier/common/constant.dart';
import 'package:stones_classifier/common/exceptions/app_exception.dart';
import 'package:stones_classifier/pages/sign_in_page.dart';
import 'package:stones_classifier/providers/authentication_provider.dart';
import 'package:stones_classifier/widgets/custom_button_widget.dart';
import 'package:stones_classifier/widgets/custom_text_form_field_widget.dart';
import 'package:stones_classifier/widgets/snackbar_widget.dart';

class ChangePasswordPage extends StatefulWidget {
  const ChangePasswordPage({
    super.key,
    required this.email,
  });

  final String email;

  @override
  State<ChangePasswordPage> createState() => _ChangePasswordPageState();
}

class _ChangePasswordPageState extends State<ChangePasswordPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    void changePassword(
      AuthenticationProvider authenticationProvider,
      String email,
      String password,
      String confirmPassword,
    ) async {
      try {
        if (email.isNotEmpty &&
            password.isNotEmpty &&
            confirmPassword.isNotEmpty) {
          if (password == confirmPassword) {
            if (await authenticationProvider.changePassword(
              email,
              password,
            )) {
              if (context.mounted) {
                Navigator.of(context).pushAndRemoveUntil(
                  PageTransition(
                    child: const SignInPage(),
                    type: PageTransitionType.rightToLeft,
                  ),
                  (Route<dynamic> route) => false,
                );
              }
            } else {
              if (context.mounted) {
                showSnackBar(
                  context,
                  "${authenticationProvider.genericResponseModel?.metadata?.message}",
                  Colors.red,
                );
              }
            }
          } else {
            if (context.mounted) {
              showSnackBar(
                context,
                "Kata sandi tidak sama.",
                Colors.red,
              );
            }
          }
        } else {
          if (context.mounted) {
            showSnackBar(
              context,
              "Isi semua data.",
              Colors.red,
            );
          }
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
    }

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
                        "Lupa Kata Sandi",
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
                          return CustomTextFormFieldWidget(
                            hintText: "Kata sandi baru",
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
                          return CustomTextFormFieldWidget(
                            hintText: "Konfirmasi kata sandi baru",
                            controller: confirmPasswordController,
                            isPasswordField: true,
                            isFilled: true,
                            isObscureText:
                                authenticationProvider.isObscureTextConfirm,
                            setObscureText: () {
                              authenticationProvider.setObscureTextConfirm();
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
                            text: "Ubah Kata Sandi",
                            color: primaryColor,
                            isLoading: authenticationProvider.isLoading,
                            onPressed: () {
                              changePassword(
                                authenticationProvider,
                                widget.email,
                                passwordController.text,
                                confirmPasswordController.text,
                              );
                            },
                          );
                        },
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
