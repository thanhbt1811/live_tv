import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:live_tv/common/constants/image_constants.dart';

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
        return Image.asset(
          ImageConstants.likeIcon,
          width: 25.w,
          height: 25.w,
        );
      case Reaction.love:
        return Image.asset(
          ImageConstants.loveIcon,
          width: 25.w,
          height: 25.w,
        );
      case Reaction.haha:
        return Image.asset(
          ImageConstants.hahaIcon,
          width: 25.w,
          height: 25.w,
        );
      case Reaction.wow:
        return Image.asset(
          ImageConstants.wowIcon,
          width: 25.w,
          height: 25.w,
        );
      case Reaction.sad:
        return Image.asset(
          ImageConstants.sadIcon,
          width: 25.w,
          height: 25.w,
        );
      case Reaction.angry:
        return Image.asset(
          ImageConstants.angryIcon,
          width: 25.w,
          height: 25.w,
        );
    }
  }
}
