import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:live_tv/common/constants/layout_constants.dart';
import 'package:live_tv/view/theme/theme_color.dart';
import 'package:live_tv/view/theme/theme_text.dart';

class AppbarWidget extends StatelessWidget implements PreferredSizeWidget {
  final bool isLeading;
  final String title;
  final List<Widget>? action;

  const AppbarWidget(
      {Key? key, this.isLeading = true, required this.title, this.action})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    final _padding = MediaQuery.of(context).padding;
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.only(
            left: LayoutConstants.paddingHorizontal, top: _padding.top + 10.h),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Visibility(
                    visible: isLeading,
                    child: InkWell(
                      onTap: () => Navigator.pop(context),
                      child: SizedBox(
                        height: 40.h,
                        width: 40.w,
                        child: Icon(
                          Icons.arrow_back_ios,
                          color: AppColor.black,
                          size: 18.w,
                        ),
                      ),
                    )),
                Text(
                  title,
                  style: ThemeText.headline.copyWith(
                      color: AppColor.black, fontWeight: FontWeight.bold),
                )
              ],
            ),
            Row(children: action ?? [])
          ],
        ),
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(40.h);
}
