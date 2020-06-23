import 'package:fastibtmsadmin/src/bloc/menu_bloc.dart';
import 'package:fastibtmsadmin/src/screens/menu_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class DashMenuCard extends StatefulWidget {
  final double leftMargin, rightMargin;
  final String cardName, vendorName;
  final List<Color> cardColors;
  final List<String> categories;

  const DashMenuCard({
    Key key,
    this.leftMargin = 0,
    this.rightMargin = 0,
    this.cardName,
    this.cardColors,
    this.categories,
    this.vendorName,
  }) : super(key: key);
  @override
  _DashMenuCardState createState() => _DashMenuCardState();
}

class _DashMenuCardState extends State<DashMenuCard> {
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
          splashColor: Colors.cyan[900],
          highlightColor: Colors.cyan[900],
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => Provider(
                  create: (_) => MenuBloc(),
                  dispose: (context, MenuBloc bloc) => bloc.dispose(),
                  child: MenuScreen(
                    categories: widget.categories,
                    vendorName: widget.vendorName,
                  ),
                ),
              ),
            );
          },
          borderRadius: BorderRadius.circular(
            5,
          ),
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
