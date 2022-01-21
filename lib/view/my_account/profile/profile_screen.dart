import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:live_tv/bloc/profile_bloc/profile_bloc.dart';
import 'package:live_tv/bloc/profile_bloc/profile_state.dart';
import 'package:live_tv/model/user_model.dart';
import 'package:live_tv/view/my_account/profile/profile_constants.dart';
import 'package:live_tv/view/my_account/profile/widget/withdrawal_widget.dart';
import 'package:live_tv/view/theme/theme_color.dart';
import 'package:live_tv/view/theme/theme_text.dart';
import 'package:live_tv/view/widget/avatar/circle_avatar.dart';
import 'package:live_tv/view/widget/button_widget/label_button_widget.dart';
import 'package:live_tv/view/widget/frame_widget.dart';
import 'package:live_tv/view/widget/loading_widget/loading_widget.dart';

class ProfileScreen extends StatefulWidget {
  final UserModel user;
  final bool isMe;

  const ProfileScreen({Key? key, required this.user, this.isMe = false})
      : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late ProfileBloc _profileBloc;

  @override
  void initState() {
    _profileBloc = BlocProvider.of<ProfileBloc>(context);
    _profileBloc.initial();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FrameWidget(
      body: Column(
        children: [
          Row(
            children: [
              InkWell(
                onTap: () => Navigator.pop(context),
                child: SizedBox(
                  height: 40.h,
                  width: 40.w,
                  child: Icon(
                    Icons.arrow_back_ios,
                    color: AppColor.black,
                    size: 18.w,
                  ),
                ),
              ),
              Text(
                ProfileConstants.profile,
                style: ThemeText.display1.copyWith(
                    color: AppColor.black, fontWeight: FontWeight.bold),
              )
            ],
          ),
          SizedBox(
            height: 10.h,
          ),
          BlocBuilder<ProfileBloc, ProfileState>(
            builder: (context, state) {
              if (state.status == ProfileStatus.loading){
                return Expanded(
                  child: Center(
                    child: LoadingWidget(),
                  ),
                );
              }
              return Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CircleAvatarWidget(
                    width: 120.w,
                    filePath: '',
                    isDefault: true,
                    height: 120.w,
                    isUpdate: false,
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  Text(
                    widget.user.displayName,
                    style: ThemeText.headline.copyWith(
                        color: AppColor.black, fontWeight: FontWeight.w600),
                  ),
                  Visibility(
                    visible: !widget.isMe,
                    child: SizedBox(
                      width: 100.w,
                      child: LabelButtonWidget(
                        label: state.user!.followed ? 'Un Follow' : 'Follow',
                        onPressed: _follow,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 30.h,
                  ),
                  Table(
                    children: [
                      TableRow(
                        children: [
                          TableCell(
                            child: Text(
                              ProfileConstants.userName,
                              style: ThemeText.overline
                                  .copyWith(color: AppColor.disableColor),
                            ),
                          ),
                          TableCell(
                            verticalAlignment:
                                TableCellVerticalAlignment.bottom,
                            child: Text(
                              state.user!.userName,
                              style: ThemeText.overline
                                  .copyWith(color: AppColor.black),
                              textAlign: TextAlign.right,
                            ),
                          ),
                        ],
                      ),
                      TableRow(
                        children: [
                          Padding(
                            padding: EdgeInsets.symmetric(vertical: 10.h),
                            child: TableCell(
                              child: Text(
                                ProfileConstants.email,
                                style: ThemeText.overline
                                    .copyWith(color: AppColor.disableColor),
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(vertical: 10.h),
                            child: TableCell(
                              verticalAlignment:
                                  TableCellVerticalAlignment.bottom,
                              child: Text(
                                state.user!.email,
                                style: ThemeText.overline
                                    .copyWith(color: AppColor.black),
                                textAlign: TextAlign.right,
                              ),
                            ),
                          ),
                        ],
                      ),
                      TableRow(
                        children: [
                          TableCell(
                            child: Text(
                              ProfileConstants.balance,
                              style: ThemeText.overline
                                  .copyWith(color: AppColor.disableColor),
                            ),
                          ),
                          TableCell(
                            verticalAlignment:
                                TableCellVerticalAlignment.bottom,
                            child: Text(
                              '${state.user!.balance} đ',
                              style: ThemeText.overline
                                  .copyWith(color: AppColor.black),
                              textAlign: TextAlign.right,
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  SizedBox(
                    width: 150.w,
                    height: 35.h,
                    child: LabelButtonWidget(
                      label: 'Withdrawal',
                      onPressed:() =>  _withdrawal(state.user?.balance ?? 0),
                    ),
                  ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }

  void _follow() {

  }
  void _withdrawal(int maxAmount){
    showModalBottomSheet(
        context: context,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        builder: (_) {
          return WithdrawalWidget(maxAmount: maxAmount);
        });
  }
}
