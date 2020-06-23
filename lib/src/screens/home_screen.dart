import 'package:fastibtmsadmin/src/bloc/login_bloc.dart';
import 'package:fastibtmsadmin/src/bloc/menu_bloc.dart';
import 'package:fastibtmsadmin/src/bloc/online_order_boc.dart';
import 'package:fastibtmsadmin/src/models/user.dart';
import 'package:fastibtmsadmin/src/models/vendor.dart';
import 'package:fastibtmsadmin/src/widgets/dash_menu_card.dart';
import 'package:fastibtmsadmin/src/widgets/dash_order_card.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  final User user;

  HomeScreen({Key key, this.title, this.user}) : super(key: key);

  final String title;

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  LoginBloc _loginBloc;

  @override
  void didChangeDependencies() {
    _loginBloc = Provider.of<LoginBloc>(context);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    _loginBloc.getVendor(widget.user.email);
    return Scaffold(

        // drawer: Drawer(
        //   child: Column(
        //     children: [
        //       DrawerHeader(
        //         child: Container(color: Colors.blue),
        //       ),
        //       RaisedButton(
        //         onPressed: () {
        //           Navigator.push(
        //               context,
        //               MaterialPageRoute(
        //                   builder: (_) => Provider(
        //                       child: MenuScreen(),
        //                       create: (_) => MenuBloc(),
        //                       dispose: (context, MenuBloc bloc) =>
        //                           bloc.dispose())));
        //         },
        //         child: Text("menu"),
        //       ),
        //       RaisedButton(
        //         onPressed: () {
        //           Navigator.push(
        //               context,
        //               MaterialPageRoute(
        //                   builder: (_) => Provider(
        //                       create: (_) => OnlineOrderBloc(),
        //                       child: OrdersScreen(),
        //                       dispose: (context, OnlineOrderBloc bloc) =>
        //                           bloc.dispose())));
        //         },
        //         child: Text("Orders"),
        //       ),
        //     ],
        //   ),
        // ),
        appBar: AppBar(
          title: Text("FAST: ADMIN"),
        ),
        body: Container(
          margin: EdgeInsets.all(10),
          child: StreamBuilder<Vendor>(
            builder: (context, snapshot) {
              if (snapshot.hasError) return Text("Error: ${snapshot.error}");
              switch (snapshot.connectionState) {
                case ConnectionState.none:
                  return Text('Awaiting Bids...');
                  break;
                case ConnectionState.waiting:
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                  break;
                case ConnectionState.active:
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Text(
                            snapshot.data.name.toUpperCase(),
                            style: GoogleFonts.nunito(
                              fontSize: 35,
                              fontStyle: FontStyle.italic,
                            ),
                          ),
                          Switch.adaptive(
                            value: snapshot.data.isBusy,
                            onChanged: (value) {
                              _loginBloc.updateStatus(
                                  value, snapshot.data.name);
                            },
                          )
                        ],
                      ),
                      Container(
                        margin: EdgeInsets.only(
                          top: 10,
                        ),
                        child: Row(
                          children: <Widget>[
                            Expanded(
                              child: Provider(
                                create: (_) => MenuBloc(),
                                dispose: (context, MenuBloc bloc) =>
                                    bloc.dispose(),
                                child: DashMenuCard(
                                  rightMargin: 7.5,
                                  cardName: "MENU",
                                  categories: snapshot.data.categories.toList(),
                                  cardColors: [
                                    Colors.cyan[500],
                                    Colors.cyan[700],
                                  ],
                                  vendorName: snapshot.data.name,
                                ),
                              ),
                            ),
                            Expanded(
                              child: Provider(
                                create: (_) => OnlineOrderBloc(),
                                dispose: (context, OnlineOrderBloc bloc) =>
                                    bloc.dispose(),
                                child: DashOrderCard(
                                  leftMargin: 7.5,
                                  cardName: "ORDERS",
                                  vendor: snapshot.data.name,
                                  cardColors: [
                                    Colors.orange[500],
                                    Colors.orange[700],
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  );
                  break;
                case ConnectionState.done:
                  return Text("The task has completed.");
                  break;
              }
              return null;
            },
            stream: _loginBloc.vendor,
          ),
        ));
  }
}
