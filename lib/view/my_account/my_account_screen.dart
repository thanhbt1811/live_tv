import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:live_tv/bloc/profile_bloc/profile_bloc.dart';
import 'package:live_tv/bloc/profile_bloc/profile_state.dart';
import 'package:live_tv/common/constants/icon_constants.dart';
import 'package:live_tv/common/constants/route_constants.dart';
import 'package:live_tv/model/stream_model.dart';
import 'package:live_tv/view/my_account/widget/avatar_appbar_widget.dart';
import 'package:live_tv/view/theme/theme_color.dart';
import 'package:live_tv/view/theme/theme_text.dart';
import 'package:live_tv/view/widget/frame_widget.dart';
import 'package:live_tv/view/widget/item_stream_widget/item_stream_widget.dart';
import 'package:live_tv/view/widget/loading_widget/loading_widget.dart';
import 'package:live_tv/view/widget/no_data_widget/no_data_widget.dart';

class MyAccountScreen extends StatefulWidget {
  @override
  State<MyAccountScreen> createState() => _MyAccountScreenState();
}

class _MyAccountScreenState extends State<MyAccountScreen> {
  late ProfileBloc _profileBloc;

  @override
  void initState() {
    _profileBloc = BlocProvider.of<ProfileBloc>(context)..initial();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FrameWidget(
        body: SafeArea(
      child: BlocListener<ProfileBloc, ProfileState>(
        listener: (context, state) {
          if (state.status == ProfileStatus.logout) {
            Navigator.pushNamedAndRemoveUntil(
                context, RouteList.login, (route) => false);
          }
        },
        child: Column(
          children: [
            BlocBuilder<ProfileBloc, ProfileState>(
                bloc: _profileBloc,
                builder: (context, state) {
                  if (state.user != null) {
                    return AvatarAppbarWidget(
                        user: state.user!,
                        logOut: _logOut,
                        viewProfile: _viewProfile);
                  } else {
                    return LoadingWidget();
                  }
                }),
            SizedBox(
              height: 20.h,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    SvgPicture.asset(
                      IconConstants.subscribeIcon,
                      color: AppColor.primaryColor,
                      width: 18.w,
                      height: 24.h,
                    ),
                    SizedBox(
                      width: 10.w,
                    ),
                    Text(
                      'My Live Stream',
                      style: ThemeText.button.copyWith(color: AppColor.black),
                    ),
                  ],
                ),
              ],
            ),
            BlocBuilder<ProfileBloc, ProfileState>(
                bloc: _profileBloc,
                builder: (context, state) {
                  if (state.streams.isEmpty) {
                    return Expanded(child: NoDataWidget());
                  }
                  if (state.status == ProfileStatus.loading) {
                    return Expanded(
                      child: Center(
                        child: LoadingWidget(),
                      ),
                    );
                  }
                  return Expanded(
                    child: RefreshIndicator(
                      onRefresh: _onRefresh,
                      child: ListView.separated(
                          shrinkWrap: true,
                          itemBuilder: (_, index) {
                            return ItemStreamWidget(
                              stream: state.streams[index],
                              play: (value) => _playStream(value),
                            );
                          },
                          separatorBuilder: (_, index) {
                            return Divider(
                              height: 1,
                              color: AppColor.disableColor,
                            );
                          },
                          itemCount: state.streams.length),
                    ),
                  );
                }),
          ],
        ),
      ),
    ));
  }

  void _logOut() {
    _profileBloc.logOut();
  }

  void _viewProfile() {
    Navigator.pushNamed(context, RouteList.profile);
  }

  Future<void> _onRefresh() async {
    _profileBloc.getStreaming();
  }

  void _playStream(StreamModel stream) {}
}
