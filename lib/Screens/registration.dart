import 'package:courierapp/Screens/home_page.dart';
import 'package:courierapp/Screens/new_orders.dart';
import 'package:courierapp/Widgets/text_widget.dart';
import 'package:courierapp/utils/config.dart';
import 'package:courierapp/utils/dynamic_sizes.dart';
import 'package:flutter/material.dart';

class Registration extends StatelessWidget {
  const Registration({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(
              maxHeight: MediaQuery.of(context).size.height * 0.92,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                topBar(context, "Registration"),
                CustomSizes().heightBox(context, 0.05),
                Padding(
                  padding: EdgeInsets.only(
                      left: CustomSizes().dynamicWidth(context, 0.05)),
                  child: Text(
                    "Let's Get Started",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: CustomSizes().dynamicWidth(context, 0.05),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                      left: CustomSizes().dynamicWidth(context, 0.05)),
                  child: Text(
                    "Fill the form to Create your new account",
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: CustomSizes().dynamicWidth(context, 0.03),
                    ),
                  ),
                ),
                CustomSizes().heightBox(context, 0.05),
                registerInputField(context, "First name"),
                registerInputField(context, "Last name"),
                registerInputField(context, "Email"),
                registerInputField(context, "Password"),
                registerInputField(context, "Mobile number"),
                CustomSizes().heightBox(context, 0.05),
                Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: CustomSizes().dynamicWidth(context, 0.05)),
                  child: colorfulButton(
                      context,
                      "Register",
                      CustomColors.customYellow,
                      CustomColors.customYellow,
                      FontWeight.bold),
                ),
                CustomSizes().heightBox(context, 0.02),
                multiColorText(context, "By clicking Register I agree with ",
                    "terms, Conditions and Agreements"),
                CustomSizes().heightBox(context, 0.02),
              ],
            ),
          ),
        ));
  }
}

Widget multiColorText(context, text, text1) {
  return Center(
    child: SizedBox(
      width: CustomSizes().dynamicWidth(context, 0.6),
      child: RichText(
        textAlign: TextAlign.center,
        text: TextSpan(
          children: [
            TextSpan(
                text: text,
                style: TextStyle(
                    color: Colors.black,
                    fontSize: CustomSizes().dynamicWidth(context, 0.025))),
            TextSpan(
                text: text1,
                style: TextStyle(
                    color: CustomColors.customYellow,
                    fontWeight: FontWeight.bold,
                    fontSize: CustomSizes().dynamicWidth(context, 0.025))),
          ],
        ),
      ),
    ),
  );
}

Widget registerInputField(context, text1) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.start,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Padding(
          padding:
              EdgeInsets.only(left: CustomSizes().dynamicWidth(context, 0.05)),
          child:
              text(context, text1, 0.03, CustomColors.customGrey, bold: true)),
      TextFormField(
        cursorColor: Colors.black,
        decoration: InputDecoration(
          focusedBorder: UnderlineInputBorder(
               borderSide: BorderSide(
              color: CustomColors.customYellow,
              width: CustomSizes().dynamicWidth(context, 0.0065),
            ),
          ),
          contentPadding: EdgeInsets.symmetric(
              horizontal: CustomSizes().dynamicWidth(context, 0.05)),
          enabledBorder:const  UnderlineInputBorder(
            borderSide: BorderSide(
              color: CustomColors.customGrey,
            ),
          ),
        ),
      ),
      CustomSizes().heightBox(context, 0.01),
    ],
  );
}
