import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:live_tv/common/constants/layout_constants.dart';
import 'package:live_tv/view/theme/theme_color.dart';
import 'package:live_tv/view/theme/theme_text.dart';
import 'package:live_tv/view/widget/button_widget/label_button_widget.dart';
import 'package:live_tv/view/widget/keybroad_avoide/keyboard_avoider.dart';
import 'package:live_tv/view/widget/text_field_widget.dart';

class WithdrawalWidget extends StatefulWidget {
  final int maxAmount;

  const WithdrawalWidget({Key? key, required this.maxAmount}) : super(key: key);

  @override
  State<WithdrawalWidget> createState() => _WithdrawalWidgetState();
}

class _WithdrawalWidgetState extends State<WithdrawalWidget> {
  final _accountNumberController = TextEditingController();
  final _amountController = TextEditingController();
  final ValueNotifier<bool> _validateNotifier = ValueNotifier(false);

  @override
  void dispose() {
    _accountNumberController.dispose();
    _amountController.dispose();
    _validateNotifier.dispose();
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
                Text(
                  'Withdrawal',
                  style: ThemeText.title.copyWith(color: AppColor.black),
                ),
                SizedBox(
                  height: 20.h,
                ),
                TextFieldWidget(
                  controller: _accountNumberController,
                  hintText: 'Enter account number',
                  onChanged: (value) {
                    _validate();
                  },
                  keyboardType: TextInputType.number,
                ),
                SizedBox(
                  height: 20.h,
                ),
                TextFieldWidget(
                  controller: _amountController,
                  hintText: 'Enter amount',
                  onChanged: (value) {
                    _validate();
                  },
                  keyboardType: TextInputType.number,
                ),
                SizedBox(
                  height: 20.h,
                ),
                ValueListenableBuilder<bool>(
                    valueListenable: _validateNotifier,
                    builder: (context, value, _) {
                      return SizedBox(
                        width: 150.w,
                        height: 50.h,
                        child: LabelButtonWidget(
                          label: 'With drawal',
                          color: value
                              ? AppColor.primaryColor
                              : AppColor.disableColor,
                          labelColor: value
                              ? AppColor.secondColor
                              : AppColor.primaryColor,
                          onPressed: value ? _withdrawal : null,
                        ),
                      );
                    }),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _withdrawal() {
    Navigator.pop(context);
  }

  void _validate() {
    if (_amountController.text.isNotEmpty &&
        _accountNumberController.text.isNotEmpty &&
        int.parse(_amountController.text) <= widget.maxAmount) {
      _validateNotifier.value = true;
    } else {
      _validateNotifier.value = false;
    }
  }
}
