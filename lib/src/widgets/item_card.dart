import 'package:cached_network_image/cached_network_image.dart';
import 'package:fastibtmsadmin/src/bloc/menu_bloc.dart';
import 'package:fastibtmsadmin/src/models/menu_item.dart';
import 'package:fastibtmsadmin/src/screens/add_menu_item.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class ItemCard extends StatefulWidget {
  final MenuItem item;
  final String vendor;
  final List<String> categories;

  const ItemCard({Key key, this.item, this.vendor, this.categories})
      : super(key: key);

  @override
  _ItemCardState createState() => _ItemCardState();
}

class _ItemCardState extends State<ItemCard> {
  MenuBloc _menuBloc;

  @override
  void didChangeDependencies() {
    _menuBloc = Provider.of<MenuBloc>(context);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    _menuBloc.getItemAvaibility(widget.item.createdAt);
    return Container(
        margin: EdgeInsets.all(10),
        child: Material(
          elevation: 5,
          borderRadius: BorderRadius.circular(5),
          child: InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => Provider(
                    create: (_) => MenuBloc(),
                    child: AddMenuScreen(
                      job: "update",
                      item: widget.item,
                      categories: widget.categories,
                    ),
                  ),
                ),
              );
            },
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: CachedNetworkImage(
                    imageUrl: widget.item.photoURI,
                    progressIndicatorBuilder: (context, url, downoadProgress) =>
                        Center(child: CircularProgressIndicator()),
                    imageBuilder: (context, imageProvider) => Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(5),
                          topLeft: Radius.circular(5),
                        ),
                        image: DecorationImage(
                          image: imageProvider,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                ),
                Row(
                  children: <Widget>[
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.all(5),
                        child: Text(
                          widget.item.name,
                          style: GoogleFonts.oswald(fontSize: 18),
                        ),
                      ),
                    ),
                    StreamBuilder<Object>(
                        stream: _menuBloc.isAvailable,
                        initialData: widget.item.isAvailable,
                        builder: (context, snapshot) {
                          if (snapshot.hasError)
                            return Text("Error: ${snapshot.error}");
                          switch (snapshot.connectionState) {
                            case ConnectionState.none:
                              return Text("Awaiting bids...");
                              break;
                            case ConnectionState.waiting:
                              return Center(
                                child: CircularProgressIndicator(),
                              );
                              break;
                            case ConnectionState.active:
                              return Switch.adaptive(
                                  value: snapshot.data,
                                  onChanged: (value) {
                                    _menuBloc.updateAvaibility(
                                      value,
                                      widget.item.createdAt,
                                    );
                                  });
                              break;
                            case ConnectionState.done:
                              return Text("The task has commpleted.");
                              break;
                          }
                        })
                  ],
                ),
              ],
            ),
          ),
        ));
  }
}
