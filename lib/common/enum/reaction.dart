import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:live_tv/common/constants/icon_constants.dart';

enum Reaction { like, love, haha, wow, sad, angry }

extension ReactionExtension on Reaction {
  String get label {
    switch (this) {
      case Reaction.like:
        return 'LIKE';
      case Reaction.love:
        return 'LOVE';
      case Reaction.haha:
        return 'HAHA';
      case Reaction.wow:
        return 'WOW';
      case Reaction.sad:
        return 'SAD';
      case Reaction.angry:
        return 'ANGRY';
    }
  }

  Widget get icon {
    switch (this) {
      case Reaction.like:
        return SvgPicture.asset(
          IconConstants.likeIcon,
          width: 15.w,
          height: 15.w,
        );
      case Reaction.love:
        return SvgPicture.asset(
          IconConstants.loveIcon,
          width: 15.w,
          height: 15.w,
        );
      case Reaction.haha:
        return SvgPicture.asset(
          IconConstants.hahaIcon,
          width: 15.w,
          height: 15.w,
        );
      case Reaction.wow:
        return SvgPicture.asset(
          IconConstants.wowIcon,
          width: 15.w,
          height: 15.w,
        );
      case Reaction.sad:
        return SvgPicture.asset(
          IconConstants.sadIcon,
          width: 15.w,
          height: 15.w,
        );
      case Reaction.angry:
        return SvgPicture.asset(
          IconConstants.angryIcon,
          width: 15.w,
          height: 15.w,
        );
    }
  }
}
