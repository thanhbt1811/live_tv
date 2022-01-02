import 'package:flutter/material.dart';
import 'package:live_tv/view/theme/theme_color.dart';

class LabelButtonWidget extends StatelessWidget {
  final Function()? onPressed;
  final String label;
  final Color? color;

  const LabelButtonWidget(
      {Key? key, this.onPressed, required this.label, this.color})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        style: ButtonStyle(
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(20)))),
            backgroundColor: MaterialStateProperty.all<Color>(
              color ?? AppColor.primaryColor,
            )),
        onPressed: onPressed,
        child: Text(label));
  }
}
