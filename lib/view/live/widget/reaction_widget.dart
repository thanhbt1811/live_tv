import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:live_tv/common/enum/reaction.dart';
import 'package:live_tv/model/reaction_model.dart';
import 'package:live_tv/view/theme/theme_color.dart';
import 'package:live_tv/view/theme/theme_text.dart';

class ReactionWidget extends StatelessWidget {
  final Map<String, List<ReactionModel>> reactionMap;

  const ReactionWidget({Key? key, required this.reactionMap}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    log('reactionMap : $reactionMap');
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: List.generate(
        Reaction.values.length,
        (index) => Row(
          children: [
            Reaction.values[index].icon,
            SizedBox(
              width: 5.w,
            ),
            Text(
              '${reactionMap[Reaction.values[index].label]?.length ?? 0}',
              style: ThemeText.subhead.copyWith(
                color: AppColor.secondColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
