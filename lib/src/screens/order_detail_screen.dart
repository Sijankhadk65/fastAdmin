import 'package:fastibtmsadmin/src/models/online_order.dart';
import 'package:fastibtmsadmin/src/widgets/cart_item_card.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class OrderDetailScreen extends StatelessWidget {
  final OnlineOrder order;

  const OrderDetailScreen({Key key, this.order}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "${order.vendor}: ${order.user.name}",
          style: GoogleFonts.oswald(
            fontSize: 15,
          ),
        ),
      ),
      body: Container(
        child: Column(children: [
          Expanded(
            child: ListView(
              shrinkWrap: true,
              children: order.items
                  .map<Widget>(
                    (item) => CartItemCard(
                      cartItem: item,
                      job: "history",
                    ),
                  )
                  .toList(),
            ),
          ),
          Container(
              margin: EdgeInsets.only(
                left: 10,
                right: 10,
                bottom: 5,
              ),
              child: Column(
                children: <Widget>[
                  Divider(),
                  Row(
                    children: <Widget>[
                      Expanded(
                        child: Text(
                          "Subtotal",
                          style: GoogleFonts.nunito(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Text(
                        "Rs.${order.totalPrice}",
                        style: GoogleFonts.nunito(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                      )
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      Expanded(
                        child: Text(
                          "Delivery",
                          style: GoogleFonts.nunito(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Text(
                        "Rs.50",
                        style: GoogleFonts.nunito(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                      )
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      Expanded(
                        child: Text(
                          "Total",
                          style: GoogleFonts.nunito(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Text(
                        "Rs.${order.totalPrice + 50}",
                        style: GoogleFonts.nunito(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                      )
                    ],
                  ),
                ],
              )),
        ]),
      ),
    );
  }
}
