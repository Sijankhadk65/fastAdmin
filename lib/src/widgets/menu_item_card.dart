import 'package:fastibtmsadmin/src/bloc/menu_bloc.dart';
import 'package:fastibtmsadmin/src/models/menu_item.dart';
import 'package:fastibtmsadmin/src/widgets/item_card.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class MenuItemCard extends StatefulWidget {
  final String category;

  const MenuItemCard({Key key, @required this.category}) : super(key: key);
  @override
  _MenuItemCardState createState() => _MenuItemCardState();
}

class _MenuItemCardState extends State<MenuItemCard> {
  MenuBloc _menuBloc;

  @override
  void didChangeDependencies() {
    _menuBloc = Provider.of<MenuBloc>(context);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    _menuBloc.getMenuItems(widget.category, "Burger House");
    return Container(
      margin: EdgeInsets.all(10),
      child: Material(
        elevation: 10,
        child: Padding(
          padding: const EdgeInsets.all(0.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.category,
                style: GoogleFonts.montserrat(
                    fontWeight: FontWeight.w900, fontSize: 25),
              ),
              Container(
                margin: EdgeInsets.symmetric(vertical: 20.0),
                height: 150.0,
                child: StreamBuilder<List<MenuItem>>(
                    stream: _menuBloc.menuItems,
                    builder: (context, snapshot) {
                      if (snapshot.hasError)
                        return Text("Error: ${snapshot.error}");
                      switch (snapshot.connectionState) {
                        case ConnectionState.none:
                          return Text("Awaiting bids......");
                          break;
                        case ConnectionState.waiting:
                          return CircularProgressIndicator();
                          break;
                        case ConnectionState.active:
                          return snapshot.data.isEmpty
                              ? Text("No Items")
                              : ListView(
                                  shrinkWrap: true,
                                  padding: EdgeInsets.all(0),
                                  scrollDirection: Axis.horizontal,
                                  children: snapshot.data
                                      .map<Widget>((item) => Provider(
                                          create: (_) => MenuBloc(),
                                          dispose: (context, MenuBloc bloc) =>
                                              bloc.dispose(),
                                          child: ItemCard(
                                            item: item,
                                          )))
                                      .toList());
                          break;
                        case ConnectionState.done:
                          return Text("The task has completed!");
                          break;
                      }
                      return null;
                    }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
