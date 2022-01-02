import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:live_tv/common/constants/icon_constants.dart';
import 'package:live_tv/view/theme/theme_color.dart';
import 'package:live_tv/view/theme/theme_text.dart';

class CircleAvatarWidget extends StatefulWidget {
  final bool? isUpdate;
  final String? avatarUrl;
  final String? sortName;
  final double width;
  final double height;
  final String filePath;
  final bool isDefault;

  const CircleAvatarWidget(
      {Key? key,
      this.isUpdate,
      this.avatarUrl,
      this.sortName,
      required this.width,
      required this.filePath,
      required this.isDefault,
      required this.height})
      : super(key: key);

  @override
  _CircleAvatarState createState() => _CircleAvatarState();
}

class _CircleAvatarState extends State<CircleAvatarWidget> {
  @override
  Widget build(BuildContext context) {
    if (widget.isUpdate ?? false) {
      return Container(
        width: widget.width,
        height: widget.height,
        decoration: const BoxDecoration(
            color: AppColor.disableColor, shape: BoxShape.circle),
        padding: EdgeInsets.all(22.w),
        child: const CircularProgressIndicator(
          strokeWidth: 2,
          valueColor: AlwaysStoppedAnimation<Color>(AppColor.primaryColor),
        ),
      );
    } else {
      if (widget.avatarUrl != null && widget.avatarUrl!.isNotEmpty) {
        return Container(
          width: widget.width,
          height: widget.height,
          decoration: const BoxDecoration(
              color: AppColor.disableColor, shape: BoxShape.circle),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(widget.width / 2),
            child: CachedNetworkImage(
                imageUrl: widget.avatarUrl!,
                height: widget.height,
                width: widget.width,
                fit: BoxFit.cover,
                placeholder: (context, url) => Padding(
                      padding: EdgeInsets.all(widget.height),
                      child: const CircularProgressIndicator(
                        strokeWidth: 2,
                        valueColor: AlwaysStoppedAnimation<Color>(
                            AppColor.primaryColor),
                      ),
                    ),
                errorWidget: (context, url, error) => const Icon(Icons.error)),
          ),
        );
      } else if (widget.isDefault) {
        return Container(
          width: widget.width,
          height: widget.height,
          decoration: const BoxDecoration(
              color: AppColor.disableColor, shape: BoxShape.circle),
          child: ClipRRect(
              borderRadius: BorderRadius.circular(widget.width / 2),
              child: SvgPicture.asset(
                IconConstants.defaultAvatar,
                height: widget.height,
                width: widget.width,
                fit: BoxFit.cover,
              )),
        );
      } else if (widget.filePath.isNotEmpty) {
        return Container(
          width: widget.width,
          height: widget.height,
          decoration: const BoxDecoration(
              color: AppColor.disableColor, shape: BoxShape.circle),
          child: ClipRRect(
              borderRadius: BorderRadius.circular(widget.width / 2),
              child: Image.file(
                File(widget.filePath),
                height: widget.height,
                width: widget.width,
                fit: BoxFit.cover,
              )),
        );
      } else {
        return Container(
          height: widget.height,
          width: widget.width,
          decoration: const BoxDecoration(
              color: AppColor.disableColor, shape: BoxShape.circle),
          alignment: Alignment.center,
          child: Text(
            widget.sortName!,
            style: ThemeText.display2,
          ),
        );
      }
    }
  }
}
