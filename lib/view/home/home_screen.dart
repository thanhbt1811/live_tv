import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:live_tv/bloc/home_bloc/home_bloc.dart';
import 'package:live_tv/bloc/home_bloc/home_state.dart';
import 'package:live_tv/common/constants/argument_constants.dart';
import 'package:live_tv/common/constants/icon_constants.dart';
import 'package:live_tv/common/constants/layout_constants.dart';
import 'package:live_tv/common/constants/route_constants.dart';
import 'package:live_tv/model/stream_model.dart';
import 'package:live_tv/view/theme/theme_color.dart';
import 'package:live_tv/view/theme/theme_text.dart';
import 'package:live_tv/view/widget/appbar_widget.dart';
import 'package:live_tv/view/widget/item_stream_widget/item_stream_widget.dart';
import 'package:live_tv/view/widget/loading_widget/loading_widget.dart';
import 'package:live_tv/view/widget/no_data_widget/no_data_widget.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late HomeBloc _homeBloc;

  @override
  void initState() {
    _homeBloc = BlocProvider.of<HomeBloc>(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppbarWidget(
        title: 'HOME',
        isLeading: false,
      ),
      body: Padding(
        padding:
            EdgeInsets.symmetric(horizontal: LayoutConstants.paddingHorizontal),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(top: 20.h),
              child: Row(
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
                        'Live Stream',
                        style: ThemeText.button.copyWith(color: AppColor.black),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            BlocBuilder<HomeBloc, HomeState>(
                bloc: _homeBloc,
                builder: (context, state) {
                  if (state.streams.isEmpty) {
                    return Expanded(
                        child:
                            InkWell(onTap: _onRefresh, child: NoDataWidget()));
                  }
                  if (state.status == HomeStatus.loading) {
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
                              play: (value) => _play(value),
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
      floatingActionButton: Container(
        width: 50.w,
        height: 50.w,
        decoration:
            BoxDecoration(color: AppColor.primaryColor, shape: BoxShape.circle),
        child: IconButton(
          onPressed: _onLive,
          icon: Icon(
            Icons.video_camera_back_outlined,
            color: AppColor.secondColor,
            size: 30.w,
          ),
        ),
      ),
    );
  }

  void _onLive() {
    Navigator.pushNamed(context, RouteList.live);
  }

  void _play(StreamModel stream) {
    Navigator.pushNamed(context, RouteList.play, arguments: {
      ArgumentConstants.steamIdKey: stream.id,
      ArgumentConstants.streamKey: stream.streamKey
    });
  }

  Future<void> _onRefresh() async {
    _homeBloc.getStreaming();
  }
}
