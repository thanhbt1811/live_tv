import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:live_tv/bloc/give_star_bloc/give_star_bloc.dart';
import 'package:live_tv/bloc/give_star_bloc/give_star_state.dart';

import 'package:live_tv/common/constants/icon_constants.dart';
import 'package:live_tv/common/constants/layout_constants.dart';
import 'package:live_tv/common/enum/give_star.dart';
import 'package:live_tv/view/play/widget/give_star_item.dart';
import 'package:live_tv/view/theme/theme_color.dart';
import 'package:live_tv/view/theme/theme_text.dart';
import 'package:live_tv/view/widget/keybroad_avoide/keyboard_avoider.dart';
import 'package:live_tv/view/widget/loading_widget/loading_widget.dart';
import 'package:live_tv/view/widget/text_field_widget.dart';

class GiveStartWidget extends StatefulWidget {
  final int streamId;
  const GiveStartWidget({
    Key? key,
    required this.streamId,
  }) : super(key: key);
  @override
  State<GiveStartWidget> createState() => _GiveStartWidgetState();
}

class _GiveStartWidgetState extends State<GiveStartWidget> {
  final ValueNotifier<GiveStar?> _starValue = ValueNotifier(GiveStar.give1);
  final ValueNotifier<int> _amountStars = ValueNotifier(GiveStar.give1.amount);
  final TextEditingController _startController =
      TextEditingController(text: '${GiveStar.give1.label}');
  late GiveStarBloc _giveStarBloc;

  @override
  void initState() {
    _giveStarBloc = BlocProvider.of<GiveStarBloc>(context);
    super.initState();
  }

  @override
  void dispose() {
    _starValue.dispose();
    _amountStars.dispose();
    _startController.dispose();
    _giveStarBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final _padding = MediaQuery.of(context).padding;
    return KeyboardAvoider(
      child: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(
                    horizontal: LayoutConstants.paddingHorizontal)
                .copyWith(bottom: _padding.bottom + 20.h),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: 20.h,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: List.generate(GiveStar.values.length, (index) {
                    final star = GiveStar.values[index];
                    return ValueListenableBuilder<GiveStar?>(
                        valueListenable: _starValue,
                        builder: (context, value, _) {
                          return GiveStarItem(
                              star: star,
                              currentStar: value,
                              onTap: _onChangeStar);
                        });
                  }),
                ),
                SizedBox(
                  height: 20.h,
                ),
                TextFieldWidget(
                  controller: _startController,
                  hintText: 'Enter other star',
                  keyboardType: TextInputType.number,
                  onChanged: (value) {
                    _amountStars.value = int.parse(value) * 200000;
                    _starValue.value = null;
                  },
                ),
                SizedBox(
                  height: 20.h,
                ),
                InkWell(
                  onTap: _giveStars,
                  child: Container(
                    height: 50.h,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: AppColor.primaryColor,
                      borderRadius: BorderRadius.all(
                        Radius.circular(20),
                      ),
                    ),
                    child: BlocConsumer<GiveStarBloc, GiveStarState>(
                        listener: (context, state) {
                      if (state.status == GiveStarStatus.getted) {
                        Navigator.pop(context);
                      }
                    }, builder: (context, state) {
                      if (state.status == GiveStarStatus.loading) {
                        return LoadingWidget(
                          loadingColor: AppColor.secondColor,
                        );
                      }
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SvgPicture.asset(
                            IconConstants.sendIcon,
                            width: 14.w,
                            height: 14.w,
                            color: AppColor.secondColor,
                          ),
                          SizedBox(
                            width: 5.w,
                          ),
                          ValueListenableBuilder<int>(
                              valueListenable: _amountStars,
                              builder: (context, value, _) {
                                return Text('Send for $value đ',
                                    style: ThemeText.subhead
                                        .copyWith(color: AppColor.secondColor));
                              })
                        ],
                      );
                    }),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _onChangeStar(GiveStar star) {
    _starValue.value = star;
    _amountStars.value = star.amount;
    _startController.text = star.label;
  }

  void _giveStars() {
    _giveStarBloc.getclientSecret(
        int.parse(_startController.text), widget.streamId);
  }
}
