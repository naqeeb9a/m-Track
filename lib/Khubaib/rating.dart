import 'package:courierapp/Screens/new_orders.dart';
import 'package:courierapp/Widgets/colorful_button.dart';
import 'package:courierapp/Widgets/text_widget.dart';
import 'package:courierapp/utils/config.dart';
import 'package:courierapp/utils/dynamic_sizes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:url_launcher/url_launcher.dart';

class RatingScreen extends StatefulWidget {
  const RatingScreen({Key? key}) : super(key: key);

  @override
  _RatingScreenState createState() => _RatingScreenState();
}

class _RatingScreenState extends State<RatingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          topBar(context, "Rating"),
          CustomSizes().heightBox(context, 0.05),
          personCard(context),
          Padding(
            padding: EdgeInsets.symmetric(
                horizontal: CustomSizes().dynamicWidth(context, 0.05)),
            child: Column(
              children: [
                CustomSizes().heightBox(context, 0.015),
                Divider(
                  thickness: CustomSizes().dynamicHeight(context, 0.001),
                ),
                CustomSizes().heightBox(context, 0.02),
                text(
                    context, "Rate Delivery Boy", 0.04, CustomColors.customGrey,
                    bold: true),
                CustomSizes().heightBox(context, 0.015),
                RatingBar.builder(
                  glow: false,
                  initialRating: 3,
                  minRating: 1,
                  direction: Axis.horizontal,
                  allowHalfRating: true,
                  itemCount: 5,
                  unratedColor: CustomColors.customGrey,
                  itemBuilder: (context, _) => const Icon(
                    Icons.star_rounded,
                    color: CustomColors.customYellow,
                  ),
                  onRatingUpdate: (rating) {},
                ),
                CustomSizes().heightBox(context, 0.09),
                colorfulButton(context, "Submit", CustomColors.customYellow,
                    CustomColors.customYellow, FontWeight.bold),
              ],
            ),
          )
        ],
      ),
    );
  }
}

Widget personCard(context,
    {name = "naqeeb",
    phone = "+92039458978",
    icon = false,
    marginline = false,
    phoneIcon = false,
    containerColor = true}) {
  return Padding(
    padding: EdgeInsets.symmetric(
        horizontal: CustomSizes().dynamicWidth(context, 0.02)),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Container(
          width: CustomSizes().dynamicWidth(context, 0.2),
          height: CustomSizes().dynamicHeight(context, 0.1),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(
              CustomSizes().dynamicWidth(context, 0.025),
            ),
            image: const DecorationImage(
              image: AssetImage("assets/userPicture.png"),
            ),
          ),
        ),
        FittedBox(
          child: text(
              context, "    $name\n    $phone", 0.04, CustomColors.customBlack,
              bold: true),
        ),
        (phoneIcon == true)
            ? InkWell(
                onTap: () async {
                  await launch("tel:$phone");
                },
                child: const Icon(
                  Icons.phone,
                  color: CustomColors.customGreen,
                ),
              )
            : Container()
      ],
    ),
  );
}
