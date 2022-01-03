import 'package:fijkplayer/fijkplayer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:live_tv/bloc/comment_bloc/comment_bloc.dart';
import 'package:live_tv/bloc/comment_bloc/comment_state.dart';
import 'package:live_tv/bloc/play_stream_bloc/play_stream_bloc.dart';
import 'package:live_tv/bloc/play_stream_bloc/play_stream_state.dart';
import 'package:live_tv/bloc/reaction_bloc/reaction_bloc.dart';
import 'package:live_tv/bloc/reaction_bloc/reaction_state.dart';
import 'package:live_tv/common/constants/icon_constants.dart';
import 'package:live_tv/common/constants/layout_constants.dart';
import 'package:live_tv/common/enum/reaction.dart';
import 'package:live_tv/view/live/widget/reaction_widget.dart';
import 'package:live_tv/view/theme/theme_color.dart';
import 'package:live_tv/view/theme/theme_text.dart';
import 'package:live_tv/view/widget/comment_widget/comment_widget.dart';
import 'package:live_tv/view/widget/keybroad_avoide/keyboard_avoider.dart';
import 'package:live_tv/view/widget/real_time_player/real_time_player.dart';
import 'package:live_tv/view/widget/text_field_widget.dart';

class PlayScreen extends StatefulWidget {
  final String streamUrl;

  const PlayScreen({Key? key, required this.streamUrl}) : super(key: key);

  @override
  State<PlayScreen> createState() => _PlayScreenState();
}

class _PlayScreenState extends State<PlayScreen> {
  late String _streamUrl;
  final _player = RealtimePlayer(FijkPlayer());
  final TextEditingController _commentController = TextEditingController();
  late PlayStreamBloc _streamBloc;
  late CommentBloc _commentBloc;
  late ReactionBloc _reactionBloc;

  @override
  void initState() {
    _streamBloc = BlocProvider.of<PlayStreamBloc>(context);
    _commentBloc = BlocProvider.of<CommentBloc>(context);
    _reactionBloc = BlocProvider.of<ReactionBloc>(context);
    _streamUrl = widget.streamUrl;
    _player.initState();
    _play();
    super.initState();
  }

  @override
  void dispose() {
    _commentController.dispose();
    _player.dispose();
    super.dispose();
  }

  Future _play() async {
    await _player.play(_streamUrl);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<PlayStreamBloc, PlayStreamState>(
        listener: (context, state) {
          if (state.status == PlayStreamStatus.end) {
            Navigator.pop(context);
          }
        },
        child: SafeArea(
            child: Stack(
          children: [
            FijkView(
              player: _player.fijk,
              panelBuilder: fijkPanel2Builder(
                fill: true,
              ),
              fit: FijkFit.fill,
              fsFit: FijkFit.fill,
              fs: false,
            ),
            Expanded(
              child: Container(
                color: AppColor.transparent,
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                      horizontal: LayoutConstants.paddingHorizontal)
                  .copyWith(top: LayoutConstants.paddingHorizontal),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  BlocBuilder<PlayStreamBloc, PlayStreamState>(
                    bloc: _streamBloc,
                    builder: (context, state) {
                      return Row(
                        children: [
                          SvgPicture.asset(
                            IconConstants.eyeOnIcon,
                            color: AppColor.secondColor,
                            width: 17.w,
                            height: 17.w,
                          ),
                          SizedBox(
                            width: 5.w,
                          ),
                          Text(
                            '${state.viewCount}',
                            style: ThemeText.subhead
                                .copyWith(color: AppColor.secondColor),
                          ),
                        ],
                      );
                    },
                  ),
                  InkWell(
                    onTap: () async {
                      Navigator.pop(context);
                    },
                    child: Icon(
                      Icons.clear,
                      color: AppColor.secondColor,
                      size: 30.w,
                    ),
                  )
                ],
              ),
            ),
            BlocBuilder<CommentBloc, CommentState>(
                bloc: _commentBloc,
                builder: (context, state) {
                  if (state.status == CommentStatus.loading ||
                      state.status == CommentStatus.success) {
                    return KeyboardAvoider(
                      child: Align(
                        alignment: Alignment.bottomLeft,
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: LayoutConstants.paddingHorizontal,
                            vertical: LayoutConstants.paddingHorizontal,
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.3,
                                child: CommentWidget(comments: state.comments),
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(vertical: 10.h),
                                child: BlocBuilder<ReactionBloc, ReactionState>(
                                    builder: (context, state) {
                                  return ReactionWidget(
                                    reactionMap: state.reactionMap,
                                    onTap: (reaction) =>
                                        _reactionBloc.reaction(reaction.label),
                                  );
                                }),
                              ),
                              SizedBox(
                                height: 30.h,
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: TextFieldWidget(
                                        controller: _commentController,
                                        hintText: 'Comment',
                                        textStyle: ThemeText.subhead.copyWith(
                                          color: AppColor.secondColor,
                                        ),
                                        onSubmitted: _commentSubmit,
                                        borderColor: AppColor.secondColor,
                                        suffixIcon: IconButton(
                                          icon: Container(
                                            decoration: BoxDecoration(
                                                shape: BoxShape.circle),
                                            child: SvgPicture.asset(
                                                IconConstants.sendIcon,
                                                width: 20.w,
                                                height: 20.w,
                                                color: AppColor.secondColor),
                                          ),
                                          onPressed: _sendComment,
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 10.w,
                                    ),
                                    Container(
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        border: Border.all(
                                            color: AppColor.secondColor,
                                            width: 1),
                                      ),
                                      child: Padding(
                                        padding: EdgeInsets.all(5.w),
                                        child: SvgPicture.asset(
                                          IconConstants.starIcon,
                                          width: 20.w,
                                          height: 20.w,
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  } else {
                    return SizedBox();
                  }
                })
          ],
        )),
      ),
    );
  }

  void _reaction(Reaction reaction) {
    _reactionBloc.reaction(reaction.label);
  }

  void _sendComment() {
    _commentBloc.comment(_commentController.text);
    _commentController.clear();
  }

  void _commentSubmit(String value) {
    _commentBloc.comment(value);
    _commentController.clear();
  }
}
