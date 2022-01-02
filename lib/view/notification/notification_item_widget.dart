import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:live_tv/common/constants/icon_constants.dart';

import 'package:live_tv/model/notification_model.dart';
import 'package:live_tv/view/theme/theme_color.dart';
import 'package:live_tv/view/theme/theme_text.dart';

class NotificationItemWidget extends StatelessWidget {
  final NotificationModel notificationModel;
  const NotificationItemWidget({
    Key? key,
    required this.notificationModel,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Text(
            notificationModel.content,
            style: ThemeText.subhead.copyWith(color: AppColor.black),
          ),
        ),
        SvgPicture.asset(
          IconConstants.nextIcon,
          color: AppColor.black,
          width: 15.h,
          height: 15.h,
        )
      ],
    );
  }
}
