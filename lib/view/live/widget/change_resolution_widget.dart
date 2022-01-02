import 'package:camera_with_rtmp/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:live_tv/common/extensions/resolution_preset_extensions.dart';
import 'package:live_tv/view/theme/theme_color.dart';
import 'package:live_tv/view/theme/theme_text.dart';

class ChangeResolutionWidget extends StatelessWidget {
  final Function(ResolutionPreset) onChange;
  final ResolutionPreset currentResolution;

  const ChangeResolutionWidget(
      {Key? key, required this.onChange, required this.currentResolution})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: List.generate(
        ResolutionPreset.values.length,
        (index) {
          final resolution = ResolutionPreset.values[index];
          return Column(
            children: [
              InkWell(
                onTap: () => onChange(resolution),
                child: Container(
                  height: 40.h,
                  alignment: Alignment.center,
                  child: Text(
                    resolution.label,
                    style: ThemeText.subhead.copyWith(
                        color: currentResolution == resolution
                            ? AppColor.primaryColor
                            : AppColor.black),
                  ),
                ),
              ),
              Visibility(
                visible: index < ResolutionPreset.values.length - 1,
                child: Divider(
                  color: AppColor.disableColor,
                  height: 1,
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
