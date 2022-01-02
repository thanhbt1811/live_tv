import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:live_tv/bloc/sign_in_bloc/sign_in_bloc.dart';
import 'package:live_tv/bloc/sign_in_bloc/sign_in_state.dart';
import 'package:live_tv/common/constants/icon_constants.dart';
import 'package:live_tv/common/constants/route_constants.dart';
import 'package:live_tv/model/sign_in_model.dart';
import 'package:live_tv/view/login/login_screen_constants.dart';
import 'package:live_tv/view/theme/theme_color.dart';
import 'package:live_tv/view/theme/theme_text.dart';
import 'package:live_tv/view/widget/button_widget/label_button_widget.dart';
import 'package:live_tv/view/widget/frame_widget.dart';
import 'package:live_tv/view/widget/text_field_widget.dart';

class LoginScreen extends StatefulWidget {
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _userNameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _loginFormKey = GlobalKey<FormState>();
  final _showPasswordValue = ValueNotifier(false);
  late SignInBloc _signInBloc;
  @override
  void initState() {
    _signInBloc = BlocProvider.of<SignInBloc>(context);
    super.initState();
  }

  @override
  void dispose() {
    _userNameController.dispose();
    _passwordController.dispose();
    _showPasswordValue.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FrameWidget(
        body: BlocListener<SignInBloc, SignInState>(
      bloc: _signInBloc,
      listener: (context, state) {
        if (state.status == SignInStatus.success) {
          Navigator.pushNamedAndRemoveUntil(
              context, RouteList.main, (route) => false);
        }
      },
      child: Form(
        key: _loginFormKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SvgPicture.asset(
              IconConstants.logo,
              color: AppColor.primaryColor,
            ),
            SizedBox(
              height: 50.h,
            ),
            TextFieldWidget(
              controller: _userNameController,
              hintText: LoginScreenConstants.userName,
              suffixIcon: IconButton(
                  onPressed: null,
                  icon: SvgPicture.asset(
                    IconConstants.profileIcon,
                    height: 18.h,
                    width: 18.w,
                  )),
            ),
            SizedBox(
              height: 10.h,
            ),
            ValueListenableBuilder<bool>(
                valueListenable: _showPasswordValue,
                builder: (context, showValue, _) {
                  return TextFieldWidget(
                    controller: _passwordController,
                    hintText: LoginScreenConstants.password,
                    obscureText: showValue,
                    suffixIcon: IconButton(
                        onPressed: _showPassword,
                        icon: showValue
                            ? SvgPicture.asset(
                                IconConstants.eyeOffIcon,
                                height: 18.h,
                                width: 18.w,
                              )
                            : SvgPicture.asset(
                                IconConstants.eyeOnIcon,
                                height: 18.h,
                                width: 18.w,
                              )),
                  );
                }),
            SizedBox(
              height: 10.h,
            ),
            SizedBox(
              height: 50.h,
              width: double.infinity,
              child: LabelButtonWidget(
                  onPressed: _login, label: LoginScreenConstants.signIn),
            ),
            SizedBox(
              height: 10.h,
            ),
            InkWell(
                onTap: _forgotPassword,
                child: Text(LoginScreenConstants.forgotPassword,
                    style: ThemeText.caption.copyWith(color: AppColor.black))),
            SizedBox(
              height: 10.h,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  LoginScreenConstants.dontHaveAnyAccount,
                  style: ThemeText.caption.copyWith(color: AppColor.black),
                ),
                SizedBox(
                  width: 5.w,
                ),
                InkWell(
                  onTap: _register,
                  child: Text(LoginScreenConstants.register,
                      style: ThemeText.caption
                          .copyWith(color: AppColor.primaryColor)),
                )
              ],
            )
          ],
        ),
      ),
    ));
  }

  void _login() {
    _signInBloc.login(SignInModel(
        userName: _userNameController.text,
        password: _passwordController.text));
  }

  void _register() {
    Navigator.pushNamed(context, RouteList.register);
  }

  void _forgotPassword() {}

  void _showPassword() {
    _showPasswordValue.value = !_showPasswordValue.value;
  }
}
