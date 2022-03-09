import 'package:courierapp/Khubaib/order_detail.dart';
import 'package:courierapp/Widgets/buttons.dart';
import 'package:courierapp/Widgets/loader.dart';
import 'package:courierapp/Widgets/text_widget.dart';
import 'package:courierapp/backend/orders.dart';
import 'package:courierapp/utils/app_routes.dart';
import 'package:courierapp/utils/config.dart';
import 'package:courierapp/utils/dynamic_sizes.dart';
import 'package:flutter/material.dart';

class ActiveOrder extends StatefulWidget {
  const ActiveOrder({Key? key}) : super(key: key);

  @override
  _ActiveOrderState createState() => _ActiveOrderState();
}

class _ActiveOrderState extends State<ActiveOrder> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: activeOrder(context, () {
        setState(() {});
      }),
    );
  }
}

Widget noActiverOrder(context) {
  return Container(
    width: CustomSizes().dynamicWidth(context, 1),
    height: CustomSizes().dynamicHeight(context, 1),
    color: CustomColors.customGrey.withOpacity(0.2),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        noactiveOrderCard(
            context,
            "https://www.pngkit.com/png/full/72-724560_png-file-tracking-parcel-png.png",
            "Send Package",
            "Deliver or recieve items such as gifts ,documents,keys",
            CustomColors.customYellow),
        CustomSizes().heightBox(context, 0.065),
        noactiveOrderCard(
            context,
            "https://cdn0.iconfinder.com/data/icons/line-design-word-processing-set-3-1/21/mailing-recipient-list-512.png",
            "I am Recipent",
            "Track an incoming delivery in the app",
            CustomColors.customBlack)
      ],
    ),
  );
}

Widget noactiveOrderCard(context, image, title, subtitle, pngColor) {
  return Container(
    width: CustomSizes().dynamicWidth(context, 0.85),
    height: CustomSizes().dynamicHeight(context, .15),
    decoration: BoxDecoration(
      color: CustomColors.customWhite,
      borderRadius: BorderRadius.circular(
        CustomSizes().dynamicWidth(context, 0.05),
      ),
    ),
    child: Row(
      children: [
        SizedBox(
          width: CustomSizes().dynamicWidth(context, 0.3),
          height: CustomSizes().dynamicHeight(context, .1),
          child: Image.network(
            image,
            color: pngColor,
          ),
        ),
        Flexible(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              text(context, title, 0.045, CustomColors.customBlack, bold: true),
              CustomSizes().heightBox(context, 0.02),
              text(context, subtitle, 0.035, CustomColors.customGrey),
            ],
          ),
        )
      ],
    ),
  );
}

Widget activeOrder(context, setState) {
  return SizedBox(
    width: CustomSizes().dynamicWidth(context, 1),
    height: CustomSizes().dynamicHeight(context, 1),
    child: FutureBuilder(
        future: RiderFunctionality().getRiderInfo(query: "active-order"),
        builder: (context, AsyncSnapshot snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.data == false) {
              return retry(context);
            } else if (snapshot.data.length == 0) {
              return Center(
                child: text(context, "No Active Orders", 0.04,
                    CustomColors.customBlack),
              );
            } else {
              List pickedOrders = [];
              List newOrders = [];
              for (var item in snapshot.data) {
                if (item["status"] == "assigned") {
                  newOrders.add(item);
                } else {
                  pickedOrders.add(item);
                }
              }
              bool isSelected1 = false;
              bool isSelected2 = false;
              return StatefulBuilder(builder: (context, changeState) {
                return Column(
                  children: [
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const SizedBox(
                          width: 20,
                        ),
                        ChoiceChip(
                            selectedColor: CustomColors.customYellow,
                            onSelected: (value) => changeState(() {
                                  isSelected1 = value;
                                }),
                            label:
                                text(context, "New Orders", 0.03, Colors.black),
                            selected: isSelected1),
                        const SizedBox(
                          width: 20,
                        ),
                        ChoiceChip(
                            onSelected: (value) => changeState(() {
                                  isSelected2 = value;
                                }),
                            selectedColor: CustomColors.customYellow,
                            label: text(
                                context, "Picked Orders", 0.03, Colors.black),
                            selected: isSelected2),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Expanded(
                      child: ListView.builder(
                        padding: EdgeInsets.symmetric(
                          vertical: CustomSizes().dynamicHeight(context, 0),
                        ),
                        itemCount: isSelected1 == true && isSelected2 == false
                            ? newOrders.length
                            : isSelected2 == true && isSelected1 == false
                                ? pickedOrders.length
                                : snapshot.data.length,
                        itemBuilder: (BuildContext context, int index) {
                          return activeOrderCard(
                              context,
                              isSelected1 == true && isSelected2 == false
                                  ? newOrders
                                  : isSelected2 == true && isSelected1 == false
                                      ? pickedOrders
                                      : snapshot.data,
                              index,
                              setState);
                        },
                      ),
                    ),
                  ],
                );
              });
            }
          } else {
            return const Loader();
          }
        }),
  );
}

Widget activeOrderCard(BuildContext context, snapshot, index, setState) {
  return InkWell(
    onTap: () {
      CustomRoutes().push(
          context,
          OrderDetail(
            snapshot: snapshot,
            index: index,
            stateChange: setState,
          ));
    },
    child: Container(
      width: CustomSizes().dynamicWidth(context, 1),
      height: CustomSizes().dynamicHeight(context, 0.24),
      padding: EdgeInsets.symmetric(
        horizontal: CustomSizes().dynamicWidth(context, 0.05),
        vertical: CustomSizes().dynamicHeight(context, 0.01),
      ),
      decoration: const BoxDecoration(
          border: Border(bottom: BorderSide(color: CustomColors.customGrey))),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              text(context, "\$" + snapshot[index]["codAmount"], 0.04,
                  CustomColors.customBlack,
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
                    0.03,
                    CustomColors.customBlack),
              )
            ],
          ),
          text(
              context,
              snapshot[index]["status"] == "assigned"
                  ? "New Courier to pick"
                  : "Courier is on the way",
              0.035,
              snapshot[index]["status"] == "assigned"
                  ? Colors.red
                  : CustomColors.customGreen,
              bold: true),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(
                Icons.circle_outlined,
                color: CustomColors.customYellow,
                size: CustomSizes().dynamicHeight(context, 0.015),
              ),
              Flexible(
                child: Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: CustomSizes().dynamicWidth(context, 0.05)),
                  child: text(
                      context,
                      snapshot[index]["pick_up_location"].toString(),
                      0.035,
                      CustomColors.customLightBlack,
                      bold: true),
                ),
              ),
            ],
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(
                Icons.circle_outlined,
                color: CustomColors.customYellow,
                size: CustomSizes().dynamicHeight(context, 0.015),
              ),
              Flexible(
                child: Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: CustomSizes().dynamicWidth(context, 0.05)),
                  child: text(
                      context,
                      snapshot[index]["consigneeAddress"].toString(),
                      0.035,
                      CustomColors.customLightBlack,
                      bold: true),
                ),
              ),
            ],
          ),
          CustomSizes().heightBox(context, 0.02)
        ],
      ),
    ),
  );
}
