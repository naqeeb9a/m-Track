import 'package:courierapp/Widgets/text_widget.dart';
import 'package:courierapp/utils/config.dart';
import 'package:courierapp/utils/dynamic_sizes.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

Widget coloredButton(context, text, color,
    {function = "", width = "", fontSize = 0.04, fontColor = true}) {
  return GestureDetector(
    onTap: function == "" ? () {} : function,
    child: Container(
      width: width == "" ? CustomSizes().dynamicWidth(context, 1) : width,
      height: CustomSizes().dynamicWidth(context, .12),
      decoration: color == CustomColors.noColor
          ? BoxDecoration(
              color: color,
              border: Border.all(width: 1, color: CustomColors.customWhite),
            )
          : BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(
                CustomSizes().dynamicWidth(
                  context,
                  1,
                ),
              ),
            ),
      child: Center(
        child: Text(
          text,
          style: TextStyle(
            color: fontColor == true
                ? CustomColors.customWhite
                : CustomColors.customBlack,
            fontWeight: FontWeight.bold,
            fontSize: CustomSizes().dynamicWidth(context, fontSize),
          ),
        ),
      ),
    ),
  );
}

Widget retry(context, setstate) {
  return Center(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        LottieBuilder.asset(
          "assets/retry.json",
          width: CustomSizes().dynamicWidth(context, 0.4),
        ),
        CustomSizes().heightBox(context, 0.02),
        text(context, "Check your internet or try again later", 0.03,
            CustomColors.customBlack),
        CustomSizes().heightBox(context, 0.1),
        coloredButton(
          context,
          "Retry",
          CustomColors.customYellow,
          width: CustomSizes().dynamicWidth(context, .4),
          function: () {
            setstate();
          },
        ),
      ],
    ),
  );
}
