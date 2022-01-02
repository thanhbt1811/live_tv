import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:live_tv/common/constants/icon_constants.dart';
import 'package:live_tv/view/widget/avatar/circle_avatar.dart';
import 'package:live_tv/common/extensions/string_extensions.dart';

class AvatarWidget extends StatelessWidget {
  final String? avatarUrl;
  final String? sortName;
  final String filePath;
  final bool? isUpdate;
  final Function() upLoadAvatar;
  final double width;
  final double height;
  final double? positionRight;
  final bool isDefault;

  const AvatarWidget(
      {Key? key,
      this.avatarUrl,
      this.sortName,
      this.isUpdate,
      required this.filePath,
      required this.width,
      required this.height,
      required this.isDefault,
      this.positionRight,
      required this.upLoadAvatar})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: upLoadAvatar,
      child: Stack(
        children: [
          CircleAvatarWidget(
              avatarUrl: avatarUrl,
              sortName: sortName!.shortenedName,
              isUpdate: isUpdate!,
              width: width,
              filePath: filePath,
              height: height,
              isDefault: isDefault),
          Positioned(
            right: positionRight ?? 0.w,
            bottom: 0,
            child: SvgPicture.asset(
              IconConstants.circleCameraICon,
              fit: BoxFit.fill,
              width: 24.w,
              height: 24.w,
            ),
          )
        ],
      ),
    );
  }
}
