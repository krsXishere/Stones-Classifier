import 'package:flutter/material.dart';
import '../common/constant.dart';

class CustomTextFormFieldWidget extends StatelessWidget {
  const CustomTextFormFieldWidget({
    super.key,
    required this.hintText,
    required this.controller,
    this.isPasswordField = false,
    this.isObscureText = false,
    this.isItalicHint = false,
    this.isFilled = false,
    this.isPrimaryBorderColor = false,
    this.isEnabled = true,
    this.setObscureText,
    this.textInputType = TextInputType.text,
    this.suffixIcon = const SizedBox.shrink(),
  });

  final String hintText;
  final TextEditingController controller;
  final bool isPasswordField,
      isObscureText,
      isEnabled,
      isItalicHint,
      isFilled,
      isPrimaryBorderColor;
  final TextInputType textInputType;
  final Function()? setObscureText;
  final Widget suffixIcon;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      style: secondaryTextStyle.copyWith(
        fontSize: 14,
      ),
      cursorColor: primaryColor,
      controller: controller,
      keyboardType: textInputType,
      obscureText: isObscureText,
      // onChanged: onChanged,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: primaryTextStyle.copyWith(
          color: grey400,
          fontStyle: isItalicHint ? FontStyle.italic : FontStyle.normal,
        ),
        filled: isFilled,
        fillColor: white,
        border: InputBorder.none,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(
            color: isPrimaryBorderColor ? primaryColor : black1,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(11),
          borderSide: BorderSide(
            color: isPrimaryBorderColor ? primaryColor : black1,
          ),
        ),
        suffixIcon: isPasswordField
            ? GestureDetector(
                onTap: setObscureText,
                child: Icon(
                  isObscureText ? Icons.visibility_off : Icons.visibility,
                  color: isObscureText ? grey400 : primaryColor,
                ),
              )
            : suffixIcon,
      ),
    );
  }
}
