import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:live_tv/common/constants/icon_constants.dart';
import 'package:live_tv/model/user_model.dart';
import 'package:live_tv/view/theme/theme_color.dart';
import 'package:live_tv/view/theme/theme_text.dart';
import 'package:live_tv/view/widget/avatar/circle_avatar.dart';

class AvatarAppbarWidget extends StatelessWidget {
  final UserModel user;
  final Function() logOut;
  final Function() viewProfile;

  const AvatarAppbarWidget(
      {Key? key,
      required this.user,
      required this.logOut,
      required this.viewProfile})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    final _padding = MediaQuery.of(context).padding;

    return Padding(
      padding: EdgeInsets.only(top: _padding.top + 10.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          InkWell(
            onTap: viewProfile,
            child: Row(
              children: [
                CircleAvatarWidget(
                  width: 80.w,
                  filePath: '',
                  isDefault: true,
                  height: 80.w,
                  isUpdate: false,
                ),
                SizedBox(
                  width: 10.w,
                ),
                Text(
                  user.displayName,
                  style: ThemeText.display2.copyWith(color: AppColor.black),
                )
              ],
            ),
          ),
          InkWell(
            onTap: logOut,
            child: SvgPicture.asset(
              IconConstants.logOutIcon,
              color: AppColor.errorColor,
              width: 18.w,
              height: 23.h,
            ),
          )
        ],
      ),
    );
  }
}
