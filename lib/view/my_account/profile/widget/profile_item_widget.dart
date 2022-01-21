import 'package:flutter/material.dart';
import 'package:live_tv/view/theme/theme_color.dart';
import 'package:live_tv/view/theme/theme_text.dart';

class ProfileItemWidget extends StatelessWidget {
  final String label;
  final String content;

  const ProfileItemWidget(
      {Key? key, required this.label, required this.content})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColor.errorColor,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            label,
            style: ThemeText.overline.copyWith(color: AppColor.disableColor),
          ),
          Expanded(
            child: Text(
              content,
              style: ThemeText.overline.copyWith(color: AppColor.black),
            ),
          )
        ],
      ),
    );
  }
}
