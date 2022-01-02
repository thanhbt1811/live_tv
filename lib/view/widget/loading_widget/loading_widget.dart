import 'package:flutter/material.dart';
import 'package:live_tv/view/theme/theme_color.dart';
import 'package:live_tv/view/widget/loading_widget/loading_constants.dart';

class LoadingWidget extends StatelessWidget {
  final Color loadingColor;
  const LoadingWidget({Key? key, this.loadingColor = AppColor.primaryColor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: LoadingConstants.loadingSize,
      width: LoadingConstants.loadingSize,
      alignment: Alignment.center,
      child: CircularProgressIndicator(
        key: ValueKey(LoadingConstants.loadingKey),
        color: loadingColor,
      ),
    );
  }
}
