import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:live_tv/common/constants/icon_constants.dart';
import 'package:live_tv/common/enum/give_star.dart';
import 'package:live_tv/view/theme/theme_color.dart';
import 'package:live_tv/view/theme/theme_text.dart';

class GiveStarItem extends StatelessWidget {
  final GiveStar star;
  final GiveStar currentStar;
  final Function(GiveStar) onTap;

  const GiveStarItem(
      {Key? key,
      required this.star,
      required this.currentStar,
      required this.onTap})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onTap(star),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: 100.w,
            height: 80.h,
            padding: EdgeInsets.symmetric(vertical: 5.h, horizontal: 10.w),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
              border: Border.all(
                  color: star == currentStar
                      ? AppColor.primaryColor
                      : AppColor.disableColor,
                  width: 1),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SvgPicture.asset(
                  IconConstants.starIcon,
                  width: 14.w,
                  height: 14.w,
                ),
                SizedBox(
                  width: 5.w,
                ),
                Text(
                  star.label,
                  style:
                      ThemeText.subhead.copyWith(color: AppColor.disableColor),
                )
              ],
            ),
          ),
          Container(
            width: 100.w,
            height: 40.h,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(20),
                bottomRight: Radius.circular(20),
              ),
              border: Border.all(
                  color: star == currentStar
                      ? AppColor.primaryColor
                      : AppColor.disableColor,
                  width: 1),
              color: star == currentStar
                  ? AppColor.primaryColor
                  : AppColor.disableColor,
            ),
            child: Text(
              '${star.amount} đ',
              style: ThemeText.subhead.copyWith(
                  color: star == currentStar
                      ? AppColor.secondColor
                      : AppColor.black),
            ),
          )
        ],
      ),
    );
  }
}
