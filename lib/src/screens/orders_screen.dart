import 'package:fastibtmsadmin/src/bloc/online_order_boc.dart';
import 'package:fastibtmsadmin/src/models/online_order.dart';
import 'package:fastibtmsadmin/src/widgets/order_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class OrdersScreen extends StatefulWidget {
  final String vendor;

  const OrdersScreen({Key key, this.vendor}) : super(key: key);

  @override
  _OrdersScreenState createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {
  OnlineOrderBloc _onlineOrderBloc;

  @override
  void didChangeDependencies() {
    _onlineOrderBloc = Provider.of<OnlineOrderBloc>(context);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    _onlineOrderBloc.getLiveOrders(widget.vendor);
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        child: StreamBuilder<List<OnlineOrder>>(
          stream: _onlineOrderBloc.liveOnlineOrders,
          builder: (context, snapshot) {
            if (snapshot.hasError) return Text(" Error: ${snapshot.error} ");
            switch (snapshot.connectionState) {
              case ConnectionState.none:
                return Text("Awaiting Bids.....");
                break;
              case ConnectionState.waiting:
                return Center(
                  child: CircularProgressIndicator(),
                );
                break;
              case ConnectionState.active:
                return snapshot.hasData
                    ? ListView(
                        children: snapshot.data
                            .map<Widget>((order) => Provider(
                                  create: (_) => OnlineOrderBloc(),
                                  dispose: (context, OnlineOrderBloc bloc) =>
                                      bloc.dispose(),
                                  child: OrderCard(
                                    order: order,
                                  ),
                                ))
                            .toList(),
                      )
                    : Center(
                        child: Text("No Live Orders"),
                      );
                break;
              case ConnectionState.done:
                return Text("The task has completed");
                break;
            }
            return null;
          },
        ),
      ),
    );
  }
}
