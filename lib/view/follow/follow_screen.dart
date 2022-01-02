import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:live_tv/bloc/follow_bloc/follow_bloc.dart';
import 'package:live_tv/bloc/follow_bloc/follow_state.dart';
import 'package:live_tv/common/constants/layout_constants.dart';
import 'package:live_tv/model/user_model.dart';
import 'package:live_tv/view/follow/widget/follow_item_widget.dart';
import 'package:live_tv/view/theme/theme_color.dart';
import 'package:live_tv/view/widget/appbar_widget.dart';
import 'package:live_tv/view/widget/loading_widget/loading_widget.dart';
import 'package:live_tv/view/widget/no_data_widget/no_data_widget.dart';

class FollowScreen extends StatefulWidget {
  @override
  State<FollowScreen> createState() => _FollowScreenState();
}

class _FollowScreenState extends State<FollowScreen> {
  late FollowBloc _followBloc;

  @override
  void initState() {
    _followBloc = BlocProvider.of<FollowBloc>(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppbarWidget(
        title: 'FOLLOW',
        isLeading: false,
      ),
      body: Padding(
        padding:
            EdgeInsets.symmetric(horizontal: LayoutConstants.paddingHorizontal)
                .copyWith(top: 20.h),
        child: BlocBuilder<FollowBloc, FollowState>(
            bloc: _followBloc,
            builder: (context, state) {
              if (state.users.isEmpty) {
                return NoDataWidget();
              }
              if (state.status == FollowStatus.loading) {
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
                      final user = state.users[index];
                      return FollowItemWidget(
                        user: user,
                        onTap: () {
                          if (user.followed) {
                            _unFollow(user);
                          } else {
                            _follow(user);
                          }
                        },
                      );
                    },
                    separatorBuilder: (_, index) {
                      return Divider(
                        height: 1,
                        color: AppColor.disableColor,
                      );
                    },
                    itemCount: state.users.length),
              );
            }),
      ),
    );
  }

  Future<void> _onRefresh() async {}
  void _follow(UserModel user) {
    _followBloc.follow(user.id);
  }

  void _unFollow(UserModel user) {
    _followBloc.unFollow(user.id);
  }
}
