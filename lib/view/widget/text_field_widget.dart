import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:live_tv/view/theme/theme_color.dart';

class TextFieldWidget extends StatelessWidget {
  final TextEditingController controller;
  final FocusNode? focusNode;
  final String? labelText;
  final String? hintText;
  final String? errorText;
  final String? initialText;
  final EdgeInsets? contentPadding;
  final TextStyle? textStyle;
  final TextInputType? keyboardType;
  final TextCapitalization textCapitalization;
  final TextInputAction? textInputAction;
  final Function(String)? onChanged;
  final String? Function(String?)? validator;
  final Function(String)? onSubmitted;
  final Function(String?)? onSaved;
  final Function()? onTap;
  final bool autoFocus;
  final bool readOnly;
  final Color borderColor;
  final bool obscureText;
  final Widget? prefixIcon;
  final Widget? suffixIcon;

  const TextFieldWidget({
    Key? key,
    required this.controller,
    this.focusNode,
    this.labelText,
    this.hintText,
    this.errorText,
    this.initialText,
    this.textStyle,
    this.keyboardType,
    this.textCapitalization = TextCapitalization.none,
    this.textInputAction,
    this.onChanged,
    this.onSubmitted,
    this.validator,
    this.onSaved,
    this.onTap,
    this.contentPadding,
    this.borderColor = AppColor.primaryColor,
    this.autoFocus = false,
    this.readOnly = false,
    this.obscureText = false,
    this.prefixIcon,
    this.suffixIcon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
        controller: controller,
        focusNode: focusNode,
        onChanged: onChanged,
        onFieldSubmitted: onSubmitted,
        onSaved: onSaved,
        onTap: onTap,
        readOnly: readOnly,
        autofocus: autoFocus,
        obscureText: obscureText,
        initialValue: initialText,
        validator: validator,
        keyboardType: keyboardType,
        style: textStyle,
        decoration: InputDecoration(
          labelText: labelText,
          alignLabelWithHint: false,
          hintText: hintText,
          hintStyle: textStyle,
          labelStyle: textStyle,
          errorText: errorText,
          prefixIcon: prefixIcon,
          suffixIcon: suffixIcon,
          contentPadding: contentPadding ?? EdgeInsets.all(10.h),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(20)),
            borderSide: BorderSide(color: borderColor, width: 1),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(20)),
            borderSide: BorderSide(color: borderColor, width: 1),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(20)),
            borderSide: BorderSide(color: borderColor, width: 1),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(20)),
            borderSide: BorderSide(color: borderColor, width: 1),
          ),
        ));
  }
}
