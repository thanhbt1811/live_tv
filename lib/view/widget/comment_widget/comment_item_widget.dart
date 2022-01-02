import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:live_tv/model/comment_model.dart';
import 'package:live_tv/view/theme/theme_color.dart';
import 'package:live_tv/view/theme/theme_text.dart';

class CommentItemWidget extends StatelessWidget {
  final CommentModel comment;

  const CommentItemWidget({Key? key, required this.comment}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: AppColor.black25,
          borderRadius: BorderRadius.all(Radius.circular(20))),
      child: Padding(
        padding: EdgeInsets.all(10.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              comment.user.displayName,
              style: ThemeText.caption.copyWith(
                  color: AppColor.secondColor, fontWeight: FontWeight.bold),
            ),
            Text(
              comment.content,
              style: ThemeText.overline.copyWith(color: AppColor.secondColor),
            ),
          ],
        ),
      ),
    );
  }
}
