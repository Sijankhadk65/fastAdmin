import 'package:fastibtmsadmin/src/bloc/menu_bloc.dart';
import 'package:fastibtmsadmin/src/models/menu_item.dart';
import 'package:fastibtmsadmin/src/widgets/item_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ItemList extends StatefulWidget {
  final String category, vendor;
  final List<String> categories;

  const ItemList({
    Key key,
    @required this.category,
    @required this.vendor,
    this.categories,
  }) : super(key: key);
  @override
  _ItemListState createState() => _ItemListState();
}

class _ItemListState extends State<ItemList> {
  MenuBloc _menuBloc;

  @override
  void didChangeDependencies() {
    _menuBloc = Provider.of<MenuBloc>(context);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    _menuBloc.getMenuItems(widget.category, widget.vendor);
    return Container(
      child: StreamBuilder<List<MenuItem>>(
        stream: _menuBloc.menuItems,
        builder: (context, snapshot) {
          if (snapshot.hasError) return Text("Error: ${snapshot.error}");
          switch (snapshot.connectionState) {
            case ConnectionState.none:
              return Text("Awaiting Bids....");
              break;
            case ConnectionState.waiting:
              return Center(child: CircularProgressIndicator());
              break;
            case ConnectionState.active:
              return snapshot.data.isNotEmpty
                  ? GridView.count(
                      crossAxisCount: 2,
                      children: snapshot.data
                          .map<Widget>(
                            (item) => Provider(
                              create: (_) => MenuBloc(),
                              dispose: (context, MenuBloc bloc) =>
                                  bloc.dispose(),
                              child: ItemCard(
                                item: item,
                                vendor: widget.vendor,
                                categories: widget.categories,
                              ),
                            ),
                          )
                          .toList(),
                    )
                  : Center(child: Text("No Items Added Yet"));
              break;
            case ConnectionState.done:
              return Text("The task has completed");
              break;
          }
          return null;
        },
      ),
    );
  }
}
