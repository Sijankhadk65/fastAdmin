import 'package:fastibtmsadmin/src/bloc/online_order_boc.dart';
import 'package:fastibtmsadmin/src/models/online_order.dart';
import 'package:fastibtmsadmin/src/screens/order_detail_screen.dart';
import 'package:fastibtmsadmin/src/widgets/status_button.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class OrderCard extends StatefulWidget {
  final OnlineOrder order;

  const OrderCard({Key key, this.order}) : super(key: key);

  @override
  _OrderCardState createState() => _OrderCardState();
}

class _OrderCardState extends State<OrderCard> {
  OnlineOrderBloc _onlineOrderBloc;

  @override
  void didChangeDependencies() {
    _onlineOrderBloc = Provider.of<OnlineOrderBloc>(context);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          gradient: LinearGradient(
            colors: [
              Colors.orange[300],
              Colors.orange[800],
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          boxShadow: [
            BoxShadow(
              blurRadius: 5,
              offset: Offset(5, 5),
              color: Colors.black26,
            ),
          ]),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(5),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => OrderDetailScreen(
                  order: widget.order,
                ),
              ),
            );
          },
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.order.user.name.toUpperCase(),
                  style: GoogleFonts.oswald(
                    fontSize: 25,
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 2,
                  ),
                ),

                Text(widget.order.totalPrice.toString()),

                Text(widget.order.createdAt),

                // ButtonBar(
                //   children: [
                //     StatusButton(
                //       onPressed: widget.order.status.contains("recieved")
                //           ? null
                //           : () {
                //               _onlineOrderBloc.setStatus(widget.order.orderID,
                //                   widget.order.status.toList(), "recieved");
                //             },
                //       message: "Recieve",
                //     ),
                //     StatusButton(
                //       onPressed: widget.order.status.contains("preparing")
                //           ? null
                //           : () {
                //               _onlineOrderBloc.setStatus(widget.order.orderID,
                //                   widget.order.status.toList(), "preparing");
                //             },
                //       message: "Prepare",
                //     ),
                //     StatusButton(
                //       onPressed: widget.order.status.contains("dispatched")
                //           ? null
                //           : () {
                //               _onlineOrderBloc.setStatus(widget.order.orderID,
                //                   widget.order.status.toList(), "dispatched");
                //             },
                //       message: "Dispatch",
                //     ),
                //   ],
                // ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
