import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:live_tv/common/constants/icon_constants.dart';
import 'package:live_tv/view/theme/theme_color.dart';
import 'package:live_tv/view/theme/theme_text.dart';

class NoDataWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SvgPicture.asset(
            IconConstants.noDataIcon,
            width: 100.w,
            height: 150.h,
          ),
          SizedBox(
            height: 10.h,
          ),
          Text(
            'No Data',
            style: ThemeText.caption.copyWith(color: AppColor.black),
            textAlign: TextAlign.center,
          )
        ],
      ),
    );
  }
}
