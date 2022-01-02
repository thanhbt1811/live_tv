import 'package:flutter/material.dart';
import 'package:live_tv/common/constants/layout_constants.dart';
import 'package:live_tv/view/theme/theme_color.dart';
import 'package:live_tv/view/widget/appbar_widget.dart';

class FrameWidget extends StatelessWidget {
  final Widget body;
  final AppbarWidget? appbar;

  const FrameWidget({Key? key, required this.body, this.appbar})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.secondColor,
      appBar: appbar,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: LayoutConstants.paddingHorizontal),
          child: body,
        ),
      ),
    );
  }
}
