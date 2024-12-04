import 'package:flutter/material.dart';
import '../common/constant.dart';

class CustomTextFormFieldWidget extends StatelessWidget {
  final String hintText;
  final bool isPasswordField,
      expands,
      showLabel,
      isNumber,
      isObsecure,
      isItalicHint,
      isFilled,
      isPrimaryBorderColor;
  final TextEditingController controller;
  final Function() onTap;
  final Function(String onChanged)? onChanged;
  final TextInputType type;
  final Widget suffixIcon;

  const CustomTextFormFieldWidget({
    super.key,
    required this.hintText,
    required this.isPasswordField,
    required this.controller,
    required this.type,
    this.isObsecure = false,
    required this.onTap,
    this.onChanged,
    this.isNumber = false,
    this.showLabel = true,
    this.expands = false,
    this.isItalicHint = false,
    this.isFilled = false,
    this.isPrimaryBorderColor = false,
    this.suffixIcon = const SizedBox.shrink(),
  });

  @override
  Widget build(BuildContext context) {
    return isPasswordField == false
        ? TextFormField(
            maxLines: expands ? 5 : 1,
            maxLength: expands ? 500 : null,
            style: primaryTextStyle.copyWith(
              fontSize: 14,
            ),
            cursorColor: primaryColor,
            controller: controller,
            keyboardType: type,
            onChanged: onChanged,
            decoration: InputDecoration(
              suffixIcon: suffixIcon,
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 10,
              ),
              filled: isFilled,
              fillColor: white,
              border: InputBorder.none,
              hintText: hintText,
              hintStyle: primaryTextStyle.copyWith(
                fontStyle: isItalicHint ? FontStyle.italic : FontStyle.normal,
                fontWeight: regular,
                color: grey400,
                fontSize: 12,
              ),
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
            ),
          )
        : TextFormField(
            style: primaryTextStyle.copyWith(
              fontSize: 14,
            ),
            cursorColor: primaryColor,
            controller: controller,
            keyboardType: type,
            obscureText: isObsecure,
            onChanged: onChanged,
            decoration: InputDecoration(
              suffixIcon: GestureDetector(
                onTap: onTap,
                child: Icon(
                  isObsecure ? Icons.visibility_off : Icons.visibility,
                  color: isObsecure ? grey500 : primaryColor,
                ),
              ),
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 10,
              ),
              filled: isFilled,
              fillColor: white,
              border: InputBorder.none,
              hintText: hintText,
              hintStyle: primaryTextStyle.copyWith(
                fontWeight: regular,
                color: grey400,
                fontSize: 12,
              ),
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
            ),
          );
  }
}
