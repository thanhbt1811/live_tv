import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:live_tv/common/constants/icon_constants.dart';
import 'package:live_tv/model/stream_model.dart';
import 'package:live_tv/view/theme/theme_color.dart';
import 'package:live_tv/view/theme/theme_text.dart';

class ItemStreamWidget extends StatelessWidget {
  final StreamModel stream;
  final Function(StreamModel) play;

  const ItemStreamWidget({Key? key, required this.stream, required this.play})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => play(stream),
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 5.h),
        child: Container(
          color: AppColor.secondColor,
          child: Row(
            children: [
              Container(
                height: 100.h,
                width: 150.w,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(15)),
                ),
                alignment: Alignment.center,
                child: SvgPicture.asset(
                  IconConstants.subscribeIcon,
                  color: AppColor.primaryColor,
                  width: 100.w,
                  height: 50.h,
                ),
              ),
              SizedBox(
                width: 10.w,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${stream.content}',
                    style: ThemeText.title.copyWith(
                        color: AppColor.black, fontWeight: FontWeight.bold),
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    '${stream.user.displayName}',
                    style: ThemeText.overline.copyWith(color: AppColor.black),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
