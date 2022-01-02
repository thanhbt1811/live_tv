import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:live_tv/model/comment_model.dart';
import 'package:live_tv/view/widget/comment_widget/comment_item_widget.dart';

class CommentWidget extends StatelessWidget {
  final List<CommentModel> comments;

  const CommentWidget({Key? key, required this.comments}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      reverse: true,
      child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: List.generate(comments.length, (index) {
            return Padding(
              padding: EdgeInsets.symmetric(vertical: 5.h),
              child: CommentItemWidget(comment: comments[index]),
            );
          }, growable: false)),
    );
  }
}
