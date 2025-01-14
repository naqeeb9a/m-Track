import 'dart:convert';

import 'package:courierapp/Screens/forgot_password.dart';
import 'package:courierapp/Screens/tab_bar.dart';
import 'package:courierapp/Widgets/input_buttons.dart';
import 'package:courierapp/Widgets/text_widget.dart';
import 'package:courierapp/backend/login_function.dart';
import 'package:courierapp/utils/app_routes.dart';
import 'package:courierapp/utils/config.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../utils/dynamic_sizes.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> with SingleTickerProviderStateMixin {
  final RoundedLoadingButtonController _btnController =
      RoundedLoadingButtonController();
  late final AnimationController _controller;
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();
  bool fieldEnable = true;
  @override
  void initState() {
    _controller =
        AnimationController(duration: const Duration(seconds: 10), vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppbar(
          context: context,
          automaticallyImplyLeading: false,
          backgroundColor: CustomColors.customYellow,
          text1: "Login"),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              CustomSizes().heightBox(context, 0.1),
              LottieBuilder.asset(
                "assets/rider.json",
                controller: _controller,
                width: CustomSizes().dynamicWidth(context, 0.8),
              ),
              CustomSizes().heightBox(context, 0.1),
              RegisterInputField(
                  context: context,
                  text1: "Email",
                  controller: _email,
                  hintText: "Enter your email",
                  enable: fieldEnable),
              CustomSizes().heightBox(context, 0.03),
              RegisterInputField(
                  context: context,
                  text1: "Password",
                  controller: _password,
                  hintText: "Enter your password",
                  password: true,
                  enable: fieldEnable),
              CustomSizes().heightBox(context, 0.1),
              InkWell(
                onTap: () => CustomRoutes().push(
                  context,
                  const ForgotPassword(),
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: CustomSizes().dynamicWidth(context, 0.05)),
                  child: Text(
                    'Forgot password',
                    style: TextStyle(
                      fontSize: CustomSizes().dynamicHeight(context, 0.015),
                      fontWeight: FontWeight.w700,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ),
              ),
              CustomSizes().heightBox(context, 0.1),
              Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: CustomSizes().dynamicWidth(context, 0.05)),
                  child: loadingButton()),
            ],
          ),
        ),
      ),
    );
  }

  loadingButton() {
    return RoundedLoadingButton(
      color: CustomColors.customYellow,
      child: const Text('Sign in', style: TextStyle(color: Colors.black)),
      controller: _btnController,
      onPressed: () async {
        _controller.forward();
        if (_email.text.isEmpty || _password.text.isEmpty) {
          _controller.reset();
          _btnController.reset();
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: text(context, "Email or password cannot be empty", 0.04,
                  CustomColors.customWhite)));
        } else if (!_email.text.contains("@")) {
          _controller.reset();
          _btnController.reset();
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: text(context, "Enter a valid email", 0.04,
                  CustomColors.customWhite)));
        } else {
          setState(() {
            fieldEnable = false;
          });

          var res =
              await UserAuthentication().loginUser(_email.text, _password.text);

          if (res == false) {
            _controller.reset();
            _btnController.reset();

            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: text(context, "Email or password incorrect", 0.04,
                    CustomColors.customWhite)));
            setState(() {
              fieldEnable = true;
            });
          } else {
            _btnController.reset();
            SharedPreferences userData = await SharedPreferences.getInstance();
            userData.setString("user", json.encode(res));
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) => const CustomTabBar()));
            _controller.reset();
            setState(() {
              fieldEnable = true;
            });
          }
        }
      },
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    _email.dispose();
    _password.dispose();
    super.dispose();
  }
}

AppBar customAppbar({
  required BuildContext context,
  required String text1,
  required bool automaticallyImplyLeading,
  required Color backgroundColor,
  bool showRiderStatus = false,
}) {
  bool isActive = false;

  getRiderInfo({Function? setstate}) async {
    SharedPreferences isRiderActive = await SharedPreferences.getInstance();

    if (isRiderActive.getBool("isActive") != null) {
      isActive = isRiderActive.getBool("isActive")!;
      setstate!();
    } else {
      isActive = false;
      setstate!();
    }
  }

  return AppBar(
    automaticallyImplyLeading: automaticallyImplyLeading,
    backgroundColor: backgroundColor,
    centerTitle: true,
    title: text(context, text1, 0.04, CustomColors.customBlack),
    actions: [
      StatefulBuilder(builder: (context, changeState) {
        getRiderInfo(setstate: () {
          changeState(() {});
        });
        return Visibility(
          visible: showRiderStatus,
          child: Row(
            children: [
              Icon(
                Icons.circle,
                color: isActive == true ? CustomColors.customGreen : Colors.red,
                size: 10,
              ),
              text(
                  context,
                  isActive == true ? "  Online   " : "  Offline   ",
                  0.04,
                  isActive == true ? CustomColors.customGreen : Colors.red,
                  bold: true)
            ],
          ),
        );
      })
    ],
  );
}
