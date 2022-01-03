import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:live_tv/view/main/main_screen_constants.dart';
import 'package:live_tv/view/theme/theme_color.dart';

final _bottomBarHeight = 62.h;

class MainScreen extends StatefulWidget {
  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen>
    with TickerProviderStateMixin, WidgetsBindingObserver {
  final _bottomNaviTypeLength = BottomNaviType.values.length;
  late double _bottom;
  late TabController _tabController;
  @override
  void initState() {
    _tabController = TabController(
        length: _bottomNaviTypeLength, vsync: this, initialIndex: 0);
    super.initState();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _bottom = MediaQuery.of(context).padding.bottom;
    return Scaffold(
      backgroundColor: AppColor.secondColor,
      body: SafeArea(
          child: IndexedStack(
        index: _tabController.index,
        children: List.generate(_bottomNaviTypeLength, (index) {
          final _bottomType = BottomNaviType.values[index];
          return _bottomType.screen;
        }),
      )),
      bottomNavigationBar: Container(
        height: _bottomBarHeight + _bottom,
        padding: EdgeInsets.only(bottom: _bottom),
        decoration: BoxDecoration(
          boxShadow: <BoxShadow>[
            BoxShadow(
              blurRadius: 10,
              spreadRadius: 3,
              color: AppColor.black.withOpacity(0.05),
              offset: const Offset(0, -6),
            ),
          ],
          color: AppColor.secondColor,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(12.r),
            topRight: Radius.circular(12.r),
          ),
        ),
        child: TabBar(
          indicatorPadding: EdgeInsets.zero,
          labelPadding: EdgeInsets.zero,
          indicatorColor: AppColor.transparent,
          controller: _tabController,
          tabs: List.generate(_bottomNaviTypeLength, (index) {
            return Tab(
              iconMargin: EdgeInsets.only(bottom: 4.h),
              icon: Center(
                child: BottomNaviType.values[index].icon(
                  BottomNaviType.values[_tabController.index],
                ),
              ),
            );
          }),
          onTap: (index) {
            setState(() {
              _tabController.index = index;
            });
          },
        ),
      ),
    );
  }
}
