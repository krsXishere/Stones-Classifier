import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:stones_classifier/common/constant.dart';
import 'package:stones_classifier/pages/change_password_page.dart';
import 'package:stones_classifier/providers/authentication_provider.dart';
import 'package:stones_classifier/widgets/custom_button_widget.dart';
import 'package:stones_classifier/widgets/custom_text_form_field_widget.dart';

class ValidateOtpPage extends StatefulWidget {
  const ValidateOtpPage({super.key});

  @override
  State<ValidateOtpPage> createState() => _ValidateOtpPageState();
}

class _ValidateOtpPageState extends State<ValidateOtpPage> {
  TextEditingController otpController = TextEditingController();

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
                        hintText: "Kode OTP",
                        controller: otpController,
                        isFilled: true,
                        textInputType: TextInputType.number,
                      ),
                      SizedBox(
                        height: defaultPadding,
                      ),
                      Consumer<AuthenticationProvider>(
                        builder: (context, authenticationProvider, child) {
                          return CustomButtonWidget(
                            text: "Konfirmasi",
                            color: primaryColor,
                            isLoading: authenticationProvider.isLoading,
                            onPressed: () {
                              Navigator.of(context).push(
                                PageTransition(
                                  child: const ChangePasswordPage(),
                                  type: PageTransitionType.rightToLeft,
                                ),
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
