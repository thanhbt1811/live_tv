import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:live_tv/common/constants/icon_constants.dart';
import 'package:live_tv/view/my_account/my_account_constants.dart';
import 'package:live_tv/view/theme/theme_color.dart';
import 'package:live_tv/view/theme/theme_text.dart';

class MenuItemWidget extends StatelessWidget {
  final MenuEnum item;
  final Function() onTapItem;

  const MenuItemWidget({Key? key, required this.item, required this.onTapItem})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTapItem,
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 10.h),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                item.icon,
                SizedBox(
                  width: 10.w,
                ),
                Text(
                  item.label,
                  style: ThemeText.button.copyWith(color: AppColor.black),
                ),
              ],
            ),
            SvgPicture.asset(
              IconConstants.nextIcon,
              width: 18.w,
              height: 24.h,
            )
          ],
        ),
      ),
    );
  }
}
