import 'package:fastibtmsadmin/src/models/cart_item.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CartItemCard extends StatelessWidget {
  final CartItem cartItem;
  final Function() decreaseCount, increaseCount;
  final String job;

  const CartItemCard({
    Key key,
    this.cartItem,
    this.decreaseCount,
    this.increaseCount,
    this.job,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10),
      padding: EdgeInsets.only(
        left: 10,
        right: 10,
        top: 10,
        bottom: 10,
      ),
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.black26,
            offset: Offset(7, 7),
            blurRadius: 10,
          ),
        ],
        borderRadius: BorderRadius.circular(5),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Colors.orange[400],
            Colors.orange[700],
          ],
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              Text(
                cartItem.name.toUpperCase(),
                style: GoogleFonts.oswald(
                  fontSize: 20,
                  color: Colors.white,
                  fontWeight: FontWeight.w700,
                  fontStyle: FontStyle.italic,
                  letterSpacing: 2,
                ),
              ),
              job == "history"
                  ? Expanded(
                      child: Container(
                        child: Text(
                          "x${cartItem.quantity}",
                          style: GoogleFonts.oswald(
                            fontSize: 20,
                            color: Colors.white,
                            fontWeight: FontWeight.w700,
                            fontStyle: FontStyle.italic,
                            letterSpacing: 2,
                          ),
                        ),
                      ),
                    )
                  : Expanded(
                      child: LayoutBuilder(
                        builder: (context, constraint) {
                          return Container(
                            margin: EdgeInsets.only(
                              left: 10,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: <Widget>[
                                Container(
                                  width: 20,
                                  height: 20,
                                  child: RawMaterialButton(
                                    fillColor: Colors.white,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(2),
                                    ),
                                    onPressed: increaseCount,
                                    child: Icon(
                                      Icons.add,
                                      size: 10,
                                    ),
                                  ),
                                ),
                                Text(
                                  cartItem.quantity.toString(),
                                  style: GoogleFonts.nunito(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.only(
                                    left: 10,
                                  ),
                                  width: 20,
                                  height: 20,
                                  child: Center(
                                    child: RawMaterialButton(
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(2),
                                      ),
                                      fillColor: Colors.white,
                                      onPressed: decreaseCount,
                                      child: Icon(
                                        Icons.remove,
                                        size: 10,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
              Text(
                "Rs.${cartItem.totalPrice}",
                style: GoogleFonts.nunito(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
