import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:live_tv/common/constants/icon_constants.dart';
import 'package:live_tv/common/constants/key_constants.dart';
import 'package:live_tv/common/constants/layout_constants.dart';
import 'package:live_tv/common/constants/route_constants.dart';
import 'package:live_tv/view/theme/theme_color.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    SchedulerBinding.instance?.addPostFrameCallback((_) {
      Future.delayed(Duration(seconds: 3), () {
        _verifyLogin();
      });
    });
    super.initState();
  }

  Future<void> _verifyLogin() async {
    final sharePref = await SharedPreferences.getInstance();
    final accessToken = sharePref.getString(KeyConstnants.accessToken);
    if (accessToken != null && accessToken.isNotEmpty) {
      Navigator.pushNamedAndRemoveUntil(
          context, RouteList.main, (route) => false);
    } else {
      Navigator.pushNamedAndRemoveUntil(
          context, RouteList.login, (route) => false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding:
            EdgeInsets.symmetric(horizontal: LayoutConstants.paddingHorizontal),
        child: Align(
          alignment: Alignment.center,
          child: SvgPicture.asset(
            IconConstants.logo,
            color: AppColor.primaryColor,
          ),
        ),
      ),
    );
  }
}
