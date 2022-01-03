import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:live_tv/bloc/follow_bloc/follow_bloc.dart';
import 'package:live_tv/bloc/home_bloc/home_bloc.dart';
import 'package:live_tv/bloc/notification_bloc/notification_bloc.dart';
import 'package:live_tv/bloc/profile_bloc/profile_bloc.dart';
import 'package:live_tv/common/constants/icon_constants.dart';
import 'package:live_tv/common/injector/injector.dart';
import 'package:live_tv/view/follow/follow_screen.dart';
import 'package:live_tv/view/home/home_screen.dart';
import 'package:live_tv/view/my_account/my_account_screen.dart';
import 'package:live_tv/view/notification/notification_screen.dart';
import 'package:live_tv/view/theme/theme_color.dart';

enum BottomNaviType { home, follow, notification, profile }

extension BottomNaviTypeExtension on BottomNaviType {
  Widget icon(BottomNaviType currentType) {
    switch (this) {
      case BottomNaviType.home:
        return Icon(
          Icons.home_outlined,
          color: currentType == BottomNaviType.home
              ? AppColor.primaryColor
              : AppColor.black,
          size: 18.w,
        );
      case BottomNaviType.follow:
        return Icon(
          Icons.favorite_outline,
          color: currentType == BottomNaviType.follow
              ? AppColor.primaryColor
              : AppColor.black,
          size: 18.w,
        );
      case BottomNaviType.notification:
        return SvgPicture.asset(
          IconConstants.ringIcon,
          color: currentType == BottomNaviType.notification
              ? AppColor.primaryColor
              : AppColor.black,
          width: 18.w,
          height: 18.w,
        );
      case BottomNaviType.profile:
        return SvgPicture.asset(
          IconConstants.profileIcon,
          color: currentType == BottomNaviType.profile
              ? AppColor.primaryColor
              : AppColor.black,
          width: 18.w,
          height: 18.w,
        );
    }
  }

  Widget get screen {
    switch (this) {
      case BottomNaviType.home:
        return BlocProvider(
          create: (_) => Injector.resolve<HomeBloc>()..getStreaming(),
          child: HomeScreen(),
        );
      case BottomNaviType.notification:
        return BlocProvider(
            create: (_) =>
                Injector.resolve<NotificationBloc>()..getNotification(),
            child: NotificationScreen());
      case BottomNaviType.follow:
        return BlocProvider(
            create: (_) => Injector.resolve<FollowBloc>()..getUser(),
            child: FollowScreen());
      case BottomNaviType.profile:
        return BlocProvider(
          create: (_) => Injector.resolve<ProfileBloc>(),
          child: MyAccountScreen(),
        );
    }
  }
}

class MainScreenConstants {}
