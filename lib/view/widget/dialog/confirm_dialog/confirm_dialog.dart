import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:live_tv/common/constants/layout_constants.dart';
import 'package:live_tv/view/theme/theme_color.dart';
import 'package:live_tv/view/theme/theme_text.dart';
import 'package:live_tv/view/widget/button_widget/label_button_widget.dart';
import 'package:live_tv/view/widget/dialog/confirm_dialog/confirm_dialog_constants.dart';

class ConfirmDialog extends StatelessWidget {
  final String message;
  final String? contentMessage;

  const ConfirmDialog({Key? key, required this.message, this.contentMessage})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      padding:
          EdgeInsets.symmetric(horizontal: LayoutConstants.paddingHorizontal),
      decoration: BoxDecoration(
          color: AppColor.secondColor,
          borderRadius: BorderRadius.all(Radius.circular(10))),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            ConfirmDialogConstants.notification,
            style: ThemeText.title
                .copyWith(color: AppColor.black, fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: 5.h,
          ),
          Text(
            message,
            style: ThemeText.caption
                .copyWith(color: AppColor.black, fontWeight: FontWeight.normal),
          ),
          SizedBox(
            height: 5.h,
          ),
          Text(
            contentMessage ?? '',
            style: ThemeText.caption
                .copyWith(color: AppColor.black, fontWeight: FontWeight.normal),
          ),
          SizedBox(
            height: 5.h,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                height: 30.h,
                child: LabelButtonWidget(
                    onPressed: () => Navigator.pop(context),
                    label: ConfirmDialogConstants.yes),
              ),
              SizedBox(
                height: 30.h,
                child: LabelButtonWidget(
                    onPressed: () => Navigator.pop(context),
                    label: ConfirmDialogConstants.no),
              )
            ],
          )
        ],
      ),
    );
  }
}
