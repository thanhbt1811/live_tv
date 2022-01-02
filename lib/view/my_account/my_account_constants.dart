import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:live_tv/common/constants/icon_constants.dart';
import 'package:live_tv/view/theme/theme_color.dart';

enum MenuEnum { subscribe, myVideo, myBag, setting, abount }

extension MenuEnumExtension on MenuEnum {
  Widget get icon {
    switch (this) {
      case MenuEnum.subscribe:
        return SvgPicture.asset(
          IconConstants.subscribeIcon,
          color: AppColor.primaryColor,
          width: 18.w,
          height: 24.h,
        );
      case MenuEnum.myVideo:
        return SvgPicture.asset(
          IconConstants.videoIcon,
          color: AppColor.primaryColor,
          width: 18.w,
          height: 24.h,
        );
      case MenuEnum.myBag:
        return SvgPicture.asset(
          IconConstants.backpackIcon,
          color: AppColor.primaryColor,
          width: 18.w,
          height: 24.h,
        );
      case MenuEnum.setting:
        return SvgPicture.asset(
          IconConstants.settingIcon,
          color: AppColor.primaryColor,
          width: 18.w,
          height: 24.h,
        );
      case MenuEnum.abount:
        return SvgPicture.asset(
          IconConstants.aboutIcon,
          color: AppColor.primaryColor,
          width: 18.w,
          height: 24.h,
        );
    }
  }

  String get label {
    switch (this) {
      case MenuEnum.subscribe:
        return translate('account.my_subscription');
      case MenuEnum.myVideo:
        return translate('account.my_video');
      case MenuEnum.myBag:
        return translate('account.my_bag');
      case MenuEnum.setting:
        return translate('account.setting');
      case MenuEnum.abount:
        return translate('account.about');
    }
  }
}

class MyAccountConstants {}
