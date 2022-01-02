import 'dart:async';
import 'dart:developer';

import 'package:camera_with_rtmp/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:live_tv/bloc/comment_bloc/comment_bloc.dart';
import 'package:live_tv/bloc/comment_bloc/comment_state.dart';
import 'package:live_tv/bloc/stream_bloc/stream_bloc.dart';
import 'package:live_tv/bloc/stream_bloc/stream_state.dart';
import 'package:live_tv/common/config/configuration.dart';
import 'package:live_tv/common/constants/icon_constants.dart';
import 'package:live_tv/common/constants/layout_constants.dart';
import 'package:live_tv/view/theme/theme_color.dart';
import 'package:live_tv/view/theme/theme_text.dart';
import 'package:live_tv/view/widget/button_widget/label_button_widget.dart';
import 'package:live_tv/view/widget/comment_widget/comment_widget.dart';
import 'package:live_tv/view/widget/keybroad_avoide/keyboard_avoider.dart';
import 'package:live_tv/view/widget/loading_widget/loading_widget.dart';
import 'package:live_tv/view/widget/text_field_widget.dart';
import 'package:wakelock/wakelock.dart';

class LiveScreen extends StatefulWidget {
  @override
  State<LiveScreen> createState() => _LiveScreenState();
}

class _LiveScreenState extends State<LiveScreen> {
  CameraController? _cameraController;
  Timer? _timer;
  List<CameraDescription> cameras = [];
  final TextEditingController _streamTitleController = TextEditingController();
  final TextEditingController _commentController = TextEditingController();
  String? url;
  late StreamBloc _streamBloc;
  late CommentBloc _commentBloc;
  @override
  void initState() {
    _streamBloc = BlocProvider.of<StreamBloc>(context);
    _commentBloc = BlocProvider.of<CommentBloc>(context);
    _getCamera().then((value) => null);
    super.initState();
  }

  Future<void> _getCamera() async {
    cameras = await availableCameras() ?? [];
    _onNewCameraSelected(cameras.last);
  }

  @override
  void dispose() {
    _cameraController?.dispose();
    _streamTitleController.dispose();
    _commentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: ()async {
         await _stopStream();
         return true;
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: SafeArea(
          child: Stack(
            children: [
              Column(
                children: [
                  Expanded(
                      child: _cameraController == null
                          ? Center(
                              child: LoadingWidget(),
                            )
                          : AspectRatio(
                              aspectRatio: _cameraController!.value.aspectRatio!,
                              child: CameraPreview(_cameraController!),
                            ))
                ],
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                        horizontal: LayoutConstants.paddingHorizontal)
                    .copyWith(top: LayoutConstants.paddingHorizontal),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    BlocBuilder<StreamBloc, StreamState>(
                      builder: (context, state) {
                        if (state.status == StreamStatus.streaming) {
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
                        } else {
                          return SizedBox();
                        }
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
              BlocConsumer<StreamBloc, StreamState>(
                bloc: _streamBloc,
                listener: (context, state) {
                  if (state.status == StreamStatus.streaming &&
                      state.streamModel != null) {
                    _onVideoStreaming(state.streamModel!.streamKey).then((value) {
                      if (mounted) setState(() {});
                      Wakelock.enable();
                    });
                    _commentBloc.getComment(state.streamModel!.id);
                  }
                },
                builder: (context, state) {
                  if (state.status == StreamStatus.streaming) {
                    return SizedBox();
                  }
                  if (state.status == StreamStatus.loading) {
                    return Center(child: LoadingWidget());
                  }
                  return KeyboardAvoider(
                    autoScroll: true,
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: LayoutConstants.paddingHorizontal),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            TextFormField(
                              controller: _streamTitleController,
                              style: ThemeText.subhead.copyWith(
                                color: AppColor.secondColor,
                              ),
                              onChanged: (value) =>
                                  _streamBloc.validateDecscription(value),
                              decoration: InputDecoration(
                                hintText: 'Tab at a decscription',
                                hintStyle: ThemeText.subhead.copyWith(
                                  color: AppColor.secondColor,
                                ),
                                enabledBorder: InputBorder.none,
                                focusedBorder: InputBorder.none,
                              ),
                            ),
                            SizedBox(
                              height: 10.h,
                            ),
                            SizedBox(
                              height: 50.h,
                              width: double.infinity,
                              child: LabelButtonWidget(
                                  onPressed: _cameraController != null &&
                                          _cameraController!
                                              .value.isInitialized! &&
                                          !_cameraController!
                                              .value.isStreamingVideoRtmp! &&
                                          state.isValid
                                      ? _startStream
                                      : null,
                                  label: 'Go Live'),
                            ),
                            SizedBox(
                              height: 20.h,
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
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
                                TextFieldWidget(
                                  controller: _commentController,
                                  hintText: 'Comment',
                                  textStyle: ThemeText.subhead.copyWith(
                                    color: AppColor.secondColor,
                                  ),
                                  onSubmitted: _commentSubmit,
                                  borderColor: AppColor.primaryColor,
                                  suffixIcon: IconButton(
                                    icon: Container(
                                      decoration:
                                          BoxDecoration(shape: BoxShape.circle),
                                      child: SvgPicture.asset(
                                        IconConstants.sendIcon,
                                        width: 20.w,
                                        height: 20.w,
                                        color: AppColor.primaryColor,
                                      ),
                                    ),
                                    onPressed: _sendComment,
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
          ),
        ),
      ),
    );
  }

  void _sendComment() {
    _commentBloc.comment(_commentController.text);
    _commentController.clear();
  }

  void _commentSubmit(String value) {
    _commentBloc.comment(value);
    _commentController.clear();
  }

  Future<void> _stopStream() async {
    if (!_cameraController!.value.isStreamingVideoRtmp!) {
      return null;
    }

    try {
      await _cameraController!.stopVideoStreaming();
      if (_timer != null) {
        _timer!.cancel();
        _timer = null;
      }
    } on CameraException {
      return null;
    }
  }

  void _startStream() {
    _streamBloc.startStream(_streamTitleController.text);
  }

  Future<String?> _onVideoStreaming(String streamKey) async {
    if (!_cameraController!.value.isInitialized!) {
      return null;
    }

    if (_cameraController!.value.isStreamingVideoRtmp!) {
      return null;
    }
    String myUrl = '${Configuration.streamHost}/$streamKey';

    try {
      if (_timer != null) {
        _timer!.cancel();
        _timer = null;
      }
      url = myUrl;
      log('stream link : $url');
      await _cameraController!.startVideoStreaming(url!);
      _timer = Timer.periodic(Duration(seconds: 1), (timer) async {
        var stats = await _cameraController!.getStreamStatistics();
        print(stats);
      });
    } on CameraException {
      return null;
    }
    return url;
  }

  void _onNewCameraSelected(CameraDescription? cameraDescription) async {
    if (_cameraController != null) {
      await _cameraController!.dispose();
    }
    _cameraController = CameraController(
      cameraDescription!,
      ResolutionPreset.veryHigh,
      enableAudio: true,
      androidUseOpenGL: true,
    );

    // If the controller is updated then update the UI.
    _cameraController!.addListener(() {
      if (mounted) setState(() {});
      if (_cameraController!.value.hasError!) {
        log('Camera error ${_cameraController!.value.errorDescription}');
        if (_timer != null) {
          _timer!.cancel();
          _timer = null;
        }
        Wakelock.disable();
      }
    });

    try {
      await _cameraController!.initialize();
    } on CameraException {
      log('CameraException : e');
    }

    if (mounted) {
      setState(() {});
    }
  }
}