import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:live_tv/bloc/notification_bloc/notification_bloc.dart';
import 'package:live_tv/bloc/notification_bloc/notification_state.dart';
import 'package:live_tv/common/constants/layout_constants.dart';
import 'package:live_tv/model/notification_model.dart';
import 'package:live_tv/view/notification/widget/notification_item_widget.dart';
import 'package:live_tv/view/theme/theme_color.dart';
import 'package:live_tv/view/widget/appbar_widget.dart';
import 'package:live_tv/view/widget/loading_widget/loading_widget.dart';
import 'package:live_tv/view/widget/no_data_widget/no_data_widget.dart';

class NotificationScreen extends StatefulWidget {
  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  late NotificationBloc _notificationBloc;

  @override
  void initState() {
    _notificationBloc = BlocProvider.of<NotificationBloc>(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppbarWidget(
        title: 'Notification',
        isLeading: false,
      ),
      body: Padding(
        padding:
            EdgeInsets.symmetric(horizontal: LayoutConstants.paddingHorizontal)
                .copyWith(top: 20.h),
        child: BlocConsumer<NotificationBloc, NotificationState>(
            bloc: _notificationBloc,
            listener: (context, state) {
              if (state.user != null) {
                _notificationBloc.subscribeNotification();
              }
            },
            builder: (context, state) {
              if (state.notifications.isEmpty) {
                return NoDataWidget();
              }
              if (state.status == NotificationStatus.loading) {
                return Expanded(
                  child: Center(
                    child: LoadingWidget(),
                  ),
                );
              }
              return RefreshIndicator(
                onRefresh: _onRefresh,
                child: ListView.separated(
                    shrinkWrap: true,
                    itemBuilder: (_, index) {
                      final noti = state.notifications[index];
                      return NotificationItemWidget(
                        onTap: () => _onTapNoti(noti),
                        notificationModel: noti,
                      );
                    },
                    separatorBuilder: (_, index) {
                      return Padding(
                        padding: EdgeInsets.symmetric(vertical: 10.h),
                        child: Divider(
                          height: 1,
                          color: AppColor.disableColor,
                        ),
                      );
                    },
                    itemCount: state.notifications.length),
              );
            }),
      ),
    );
  }

  Future<void> _onRefresh() async {
    _notificationBloc.getNotification();
  }

  void _onTapNoti(NotificationModel noti) {
    _notificationBloc.readNotification(noti.id);
  }
}
