import 'package:fastibtmsadmin/src/bloc/online_order_boc.dart';
import 'package:fastibtmsadmin/src/screens/orders_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class DashOrderCard extends StatefulWidget {
  final double leftMargin, rightMargin;
  final String cardName, vendor;
  final List<Color> cardColors;

  const DashOrderCard({
    Key key,
    this.leftMargin = 0,
    this.rightMargin = 0,
    this.cardName,
    this.cardColors,
    this.vendor,
  }) : super(key: key);
  @override
  _DashOrderCardState createState() => _DashOrderCardState();
}

class _DashOrderCardState extends State<DashOrderCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        left: widget.leftMargin,
        right: widget.rightMargin,
      ),
      height: 150,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: widget.cardColors,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black26,
            offset: Offset(5, 5),
            blurRadius: 5,
          )
        ],
        borderRadius: BorderRadius.circular(
          5,
        ),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => Provider(
                  create: (_) => OnlineOrderBloc(),
                  dispose: (context, OnlineOrderBloc bloc) => bloc.dispose(),
                  child: OrdersScreen(
                    vendor: widget.vendor,
                  ),
                ),
              ),
            );
          },
          splashColor: Colors.orange[900],
          highlightColor: Colors.orange[900],
          borderRadius: BorderRadius.circular(5),
          child: Padding(
            padding: const EdgeInsets.only(
              left: 10.0,
              right: 10,
              top: 5,
              bottom: 5,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  widget.cardName,
                  style: GoogleFonts.oswald(
                    color: Colors.white,
                    fontSize: 25,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 2,
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
