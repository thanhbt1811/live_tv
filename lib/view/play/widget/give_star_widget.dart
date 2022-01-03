import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:live_tv/common/constants/icon_constants.dart';
import 'package:live_tv/common/constants/layout_constants.dart';
import 'package:live_tv/common/enum/give_star.dart';
import 'package:live_tv/view/play/widget/give_star_item.dart';
import 'package:live_tv/view/theme/theme_color.dart';
import 'package:live_tv/view/theme/theme_text.dart';

class GiveStartWidget extends StatefulWidget {
  @override
  State<GiveStartWidget> createState() => _GiveStartWidgetState();
}

class _GiveStartWidgetState extends State<GiveStartWidget> {
  final ValueNotifier<GiveStar> _starValue = ValueNotifier(GiveStar.give10);

  @override
  void dispose() {
    _starValue.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final _padding = MediaQuery.of(context).padding;
    return SafeArea(
      child: Padding(
        padding:
            EdgeInsets.symmetric(horizontal: LayoutConstants.paddingHorizontal)
                .copyWith(bottom: _padding.bottom + 20.h),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 20.h,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: List.generate(GiveStar.values.length, (index) {
                final star = GiveStar.values[index];
                return ValueListenableBuilder<GiveStar>(
                    valueListenable: _starValue,
                    builder: (context, value, _) {
                      return GiveStarItem(
                          star: star, currentStar: value, onTap: _onChangeStar);
                    });
              }),
            ),
            SizedBox(
              height: 20.h,
            ),
            Container(
              height: 50.h,
              decoration: BoxDecoration(
                color: AppColor.primaryColor,
                borderRadius: BorderRadius.all(
                  Radius.circular(20),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SvgPicture.asset(
                    IconConstants.sendIcon,
                    width: 14.w,
                    height: 14.w,
                    color: AppColor.secondColor,
                  ),
                  SizedBox(
                    width: 5.w,
                  ),
                  Text('Send for ${_starValue.value.amount}đ',
                      style: ThemeText.subhead
                          .copyWith(color: AppColor.secondColor))
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  void _onChangeStar(GiveStar star) {
    _starValue.value = star;
  }
}
