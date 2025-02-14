import 'package:courierapp/Khubaib/order_detail.dart';
import 'package:courierapp/Widgets/text_widget.dart';
import 'package:courierapp/utils/app_routes.dart';
import 'package:courierapp/utils/config.dart';
import 'package:courierapp/utils/dynamic_sizes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:lottie/lottie.dart';

import '../Widgets/buttons.dart';
import '../Widgets/loader.dart';
import '../backend/orders.dart';

class CompletedOrder extends StatefulWidget {
  const CompletedOrder({Key? key}) : super(key: key);

  @override
  _CompletedOrderState createState() => _CompletedOrderState();
}

class _CompletedOrderState extends State<CompletedOrder>
    with SingleTickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColors.customYellow.withOpacity(0.2),
      body: completedOrder(context, () {
        setState(() {});
      }),
    );
  }
}

Widget noCompletedOrder(context, _controller) {
  return SizedBox(
    width: CustomSizes().dynamicWidth(context, 1),
    height: CustomSizes().dynamicHeight(context, 1),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        LottieBuilder.asset(
          "assets/noData.json",
          controller: _controller,
          width: CustomSizes().dynamicWidth(context, 0.4),
        ),
        CustomSizes().heightBox(context, 0.03),
        text(context, "Oooops !", 0.06, CustomColors.customLightBlack,
            bold: true),
        CustomSizes().heightBox(context, 0.04),
        text(context, "No Data Found!", 0.04, CustomColors.customGrey,
            bold: true),
      ],
    ),
  );
}

Widget completedOrder(context, setState) {
  return SizedBox(
    width: CustomSizes().dynamicWidth(context, 1),
    height: CustomSizes().dynamicHeight(context, 1),
    child: FutureBuilder(
        future: RiderFunctionality().getRiderInfo(query: "delivered-order"),
        builder: (context, AsyncSnapshot snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.data == false) {
              return retry(context, setState);
            } else if (snapshot.data.length == 0) {
              return Center(
                child: text(context, "No Completed Orders", 0.04,
                    CustomColors.customBlack),
              );
            } else {
              return ListView.builder(
                padding: EdgeInsets.symmetric(
                  vertical: CustomSizes().dynamicHeight(context, 0),
                ),
                itemCount: snapshot.data.length,
                itemBuilder: (BuildContext context, int index) {
                  return completedOrderCard(
                      context, snapshot.data, index, setState);
                },
              );
            }
          } else {
            return const Loader();
          }
        }),
  );
}

Widget completedOrderCard(
    BuildContext context, List snapshot, index, setState) {
  return InkWell(
    onTap: () => CustomRoutes().push(
        context,
        OrderDetail(
          snapshot: snapshot,
          index: index,
          stateChange: setState,
        )),
    child: Container(
      padding: EdgeInsets.symmetric(
        horizontal: CustomSizes().dynamicWidth(context, 0.05),
        vertical: CustomSizes().dynamicHeight(context, 0.02),
      ),
      margin: EdgeInsets.symmetric(
        vertical: CustomSizes().dynamicHeight(context, 0.02),
      ),
      color: CustomColors.customWhite,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              text(
                  context,
                  snapshot[index]["updated_at"].toString().substring(0, 10),
                  0.035,
                  CustomColors.customGrey,
                  bold: true),
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: CustomSizes().dynamicWidth(context, 0.01),
                ),
                decoration: BoxDecoration(
                  color: CustomColors.customGrey,
                  borderRadius: BorderRadius.circular(
                    CustomSizes().dynamicWidth(context, 0.05),
                  ),
                ),
                child: text(
                    context,
                    "Order no #" + snapshot[index]["custRefNo"].toString(),
                    0.04,
                    CustomColors.customBlack),
              )
            ],
          ),
          text(
              context,
              "PKR. " +
                  double.parse(snapshot[index]["codAmount"]).toStringAsFixed(0),
              0.04,
              CustomColors.customBlack,
              bold: true),
          text(context, snapshot[index]["reviews"].toString(), 0.03,
              CustomColors.customLightBlack,
              bold: true),
          IgnorePointer(
            ignoring: true,
            child: RatingBar.builder(
              glow: false,
              initialRating:
                  double.parse((snapshot[index]["rating"] ?? "0").toString()),
              minRating: 1,
              direction: Axis.horizontal,
              itemCount: 5,
              itemSize: CustomSizes().dynamicWidth(context, 0.05),
              unratedColor: CustomColors.customGrey,
              itemBuilder: (context, _) => const Icon(
                Icons.star_rounded,
                color: CustomColors.customYellow,
              ),
              onRatingUpdate: (rating) {},
            ),
          ),
        ],
      ),
    ),
  );
}
