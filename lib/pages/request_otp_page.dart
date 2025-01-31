import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:stones_classifier/common/constant.dart';
import 'package:stones_classifier/common/exceptions/app_exception.dart';
import 'package:stones_classifier/pages/validate_otp_page.dart';
import 'package:stones_classifier/providers/authentication_provider.dart';
import 'package:stones_classifier/widgets/custom_button_widget.dart';
import 'package:stones_classifier/widgets/custom_text_form_field_widget.dart';
import 'package:stones_classifier/widgets/snackbar_widget.dart';

class RequestOtpPage extends StatefulWidget {
  const RequestOtpPage({super.key});

  @override
  State<RequestOtpPage> createState() => _RequestOtpPageState();
}

class _RequestOtpPageState extends State<RequestOtpPage> {
  TextEditingController emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    void requestOtp(
      AuthenticationProvider authenticationProvider,
      String email,
    ) async {
      try {
        if (email.isNotEmpty) {
          if (await authenticationProvider.requestOtp(email)) {
            if (context.mounted) {
              Navigator.of(context).push(
                PageTransition(
                  child: ValidateOtpPage(
                    email: email,
                  ),
                  type: PageTransitionType.rightToLeft,
                ),
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
                          return CustomButtonWidget(
                            text: "Kirim OTP",
                            color: primaryColor,
                            isLoading: authenticationProvider.isLoading,
                            onPressed: () {
                              requestOtp(
                                authenticationProvider,
                                emailController.text,
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
