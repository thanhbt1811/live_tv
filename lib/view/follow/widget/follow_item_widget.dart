import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:live_tv/common/constants/layout_constants.dart';
import 'package:live_tv/model/user_model.dart';
import 'package:live_tv/view/theme/theme_color.dart';
import 'package:live_tv/view/theme/theme_text.dart';
import 'package:live_tv/view/widget/button_widget/label_button_widget.dart';

class FollowItemWidget extends StatelessWidget {
  final UserModel user;
  final Function() onTap;

  const FollowItemWidget({Key? key, required this.user, required this.onTap})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration:
          BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(20))),
      padding:
          EdgeInsets.symmetric(horizontal: LayoutConstants.paddingHorizontal),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            user.displayName,
            style: ThemeText.subhead.copyWith(color: AppColor.black),
          ),
          SizedBox(
            width: 100.w,
            child: LabelButtonWidget(
              label: user.followed ? 'Unfollow' : 'Follow',
              onPressed: onTap,
            ),
          )
        ],
      ),
    );
  }
}
