import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:live_tv/bloc/sign_up_bloc/sign_up_bloc.dart';
import 'package:live_tv/bloc/sign_up_bloc/sign_up_state.dart';
import 'package:live_tv/common/constants/icon_constants.dart';
import 'package:live_tv/common/constants/route_constants.dart';
import 'package:live_tv/view/register/reigster_screen_constants.dart';
import 'package:live_tv/view/theme/theme_color.dart';
import 'package:live_tv/view/widget/appbar_widget.dart';
import 'package:live_tv/view/widget/button_widget/label_button_widget.dart';
import 'package:live_tv/view/widget/frame_widget.dart';
import 'package:live_tv/view/widget/text_field_widget.dart';

class RegisterScreen extends StatefulWidget {
  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _registerFormKey = GlobalKey<FormState>();
  final _userNameController = TextEditingController();
  final _displayNameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _emailController = TextEditingController();
  final _showPasswordValue = ValueNotifier(true);
  late SignUpBloc _signUpBloc;
  @override
  void initState() {
    _signUpBloc = BlocProvider.of<SignUpBloc>(context);
    super.initState();
  }

  @override
  void dispose() {
    _userNameController.dispose();
    _displayNameController.dispose();
    _passwordController.dispose();
    _emailController.dispose();
    _showPasswordValue.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FrameWidget(
        appbar: AppbarWidget(
          title: RegisterScreenConstants.register,
          isLeading: true,
        ),
        body: BlocListener<SignUpBloc, SignUpState>(
          listener: (context, state) {
            if (state.status == SignUpStatus.success) {
              Navigator.pushNamedAndRemoveUntil(
                  context, RouteList.login, (route) => false);
            }
          },
          child: Form(
              key: _registerFormKey,
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
                    hintText: RegisterScreenConstants.userName,
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
                  TextFieldWidget(
                    controller: _displayNameController,
                    hintText: RegisterScreenConstants.displayName,
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
                          hintText: RegisterScreenConstants.password,
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
                  TextFieldWidget(
                    controller: _emailController,
                    hintText: RegisterScreenConstants.email,
                    suffixIcon: IconButton(
                        onPressed: null,
                        icon: Icon(
                          Icons.email_outlined,
                          color: AppColor.black,
                          size: 18.h,
                        )),
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  SizedBox(
                    height: 50.h,
                    width: double.infinity,
                    child: LabelButtonWidget(
                        onPressed: _register,
                        label: RegisterScreenConstants.signUp),
                  ),
                ],
              )),
        ));
  }

  void _register() {
    _signUpBloc.signUp(
        username: _userNameController.text,
        password: _passwordController.text,
        email: _emailController.text,
        displayName: _displayNameController.text);
  }

  void _showPassword() {
    _showPasswordValue.value = !_showPasswordValue.value;
  }
}
