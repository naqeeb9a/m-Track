import 'dart:convert';

import 'package:courierapp/Screens/login.dart';

import 'package:courierapp/Widgets/colorful_button.dart';
import 'package:courierapp/Widgets/input_buttons.dart';
import 'package:courierapp/utils/app_routes.dart';
import 'package:courierapp/utils/config.dart';
import 'package:courierapp/utils/dynamic_sizes.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Screens/change_password.dart';

class PersonalDetails extends StatefulWidget {
  final Map riderDetails;
  const PersonalDetails({Key? key, required this.riderDetails})
      : super(key: key);

  @override
  _PersonalDetailsState createState() => _PersonalDetailsState();
}

class _PersonalDetailsState extends State<PersonalDetails> {
  final TextEditingController _controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppbar(
          context: context,
          text1: "Personal Details",
          automaticallyImplyLeading: true,
          backgroundColor: CustomColors.customYellow),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CustomSizes().heightBox(context, 0.09),
          Hero(
            tag: 1,
            child: CircleAvatar(
              radius: CustomSizes().dynamicWidth(context, 0.1),
              backgroundImage: NetworkImage(widget.riderDetails["image"]),
            ),
          ),
          registerInputField(
              context, "Name", _controller, widget.riderDetails["name"],
              enable: false),
          registerInputField(
              context, "Type", _controller, widget.riderDetails["type"],
              enable: false),
          registerInputField(
              context, "Cnic", _controller, widget.riderDetails["nic"],
              enable: false),
          registerInputField(context, "Mobile number", _controller,
              widget.riderDetails["phone"],
              enable: false),
          registerInputField(
              context, "Email", _controller, widget.riderDetails["email"],
              enable: false),
          CustomSizes().heightBox(context, 0.05),
          InkWell(
            onTap: () async {
              SharedPreferences userData =
                  await SharedPreferences.getInstance();
              var riderData = jsonDecode(userData.getString("user").toString());
              CustomRoutes().push(
                context,
                ChangePassword(
                  email: riderData["data"]["email"],
                ),
              );
            },
            child: Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: CustomSizes().dynamicWidth(context, 0.05)),
              child: Text(
                'Change your Password',
                style: TextStyle(
                  fontSize: CustomSizes().dynamicHeight(context, 0.015),
                  fontWeight: FontWeight.w700,
                  decoration: TextDecoration.underline,
                ),
              ),
            ),
          ),
          CustomSizes().heightBox(context, 0.05),
          Padding(
            padding: EdgeInsets.symmetric(
                horizontal: CustomSizes().dynamicWidth(context, 0.05)),
            child: colorfulButton(
                context,
                "Edit Profile",
                CustomColors.customYellow,
                CustomColors.customYellow,
                FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
