import 'package:fastibtmsadmin/src/bloc/menu_bloc.dart';
import 'package:fastibtmsadmin/src/screens/add_menu_item.dart';
import 'package:fastibtmsadmin/src/screens/items_list.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MenuScreen extends StatefulWidget {
  final List<String> categories;
  final String vendorName;

  const MenuScreen({Key key, this.categories, this.vendorName})
      : super(key: key);
  @override
  _MenuScreenState createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen>
    with SingleTickerProviderStateMixin {
  TabController _tabController;

  @override
  void initState() {
    _tabController =
        TabController(length: widget.categories.length, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Menu Screen"),
        bottom: TabBar(
            isScrollable: true,
            controller: _tabController,
            tabs: widget.categories
                .map<Widget>(
                  (e) => Tab(
                    child: Text(e),
                  ),
                )
                .toList()),
      ),
      body: TabBarView(
        controller: _tabController,
        children: widget.categories
            .map<Widget>(
              (category) => Provider(
                create: (_) => MenuBloc(),
                dispose: (context, MenuBloc bloc) => bloc.dispose(),
                child: ItemList(
                  category: category,
                  vendor: widget.vendorName,
                  categories: widget.categories,
                ),
              ),
            )
            .toList(),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => Provider(
                child: AddMenuScreen(
                  categories: widget.categories,
                  vendor: widget.vendorName,
                ),
                create: (_) => MenuBloc(),
                dispose: (context, MenuBloc bloc) => bloc.dispose(),
              ),
            ),
          );
        },
        child: Icon(Icons.add_to_queue),
      ),
    );
  }
}
