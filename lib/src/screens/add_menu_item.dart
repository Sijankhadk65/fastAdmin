import 'dart:io';

import 'package:fastibtmsadmin/src/bloc/menu_bloc.dart';
import 'package:fastibtmsadmin/src/models/menu_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:toast/toast.dart';

class AddMenuScreen extends StatefulWidget {
  final String job;
  final List<String> categories;
  final String vendor;
  final MenuItem item;

  const AddMenuScreen(
      {Key key, this.job, this.categories, this.vendor, this.item})
      : super(key: key);
  @override
  _AddMenuScreenState createState() => _AddMenuScreenState();
}

class _AddMenuScreenState extends State<AddMenuScreen> {
  MenuBloc _menuBloc;
  TextEditingController _nameController, _priceController;

  @override
  void initState() {
    _nameController = TextEditingController();
    _priceController = TextEditingController();
    updateControllers();
    super.initState();
  }

  updateControllers() {
    if (widget.job == "update") {
      _nameController.text = widget.item.name;
      _priceController.text = widget.item.price.toString();
    }
  }

  updateSubjects() {
    if (widget.job == "update") {
      _menuBloc.changeAvaibility(widget.item.isAvailable);
      _menuBloc.changeCategory(widget.item.category);
      _menuBloc.changeItemPrice(widget.item.price.toString());
      _menuBloc.changeItemName(widget.item.name);
    }
  }

  @override
  void didChangeDependencies() {
    _menuBloc = Provider.of<MenuBloc>(context);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    _menuBloc.changeCategories(widget.categories);
    _menuBloc.changeSelectedCategory(widget.categories.first);
    updateSubjects();
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        padding: EdgeInsets.only(top: 10, left: 5, right: 5),
        child: ListView(
          physics: ClampingScrollPhysics(),
          children: [
            Center(
              child: StreamBuilder<String>(
                  stream: _menuBloc.imagepath,
                  builder: (context, snapshot) {
                    return snapshot.hasData
                        ? Container(
                            height: 150,
                            width: 150,
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                    image: FileImage(File(snapshot.data)))),
                          )
                        : Container(
                            height: 150,
                            width: 150,
                            color: Colors.grey,
                          );
                  }),
            ),
            ButtonBar(
              alignment: MainAxisAlignment.center,
              children: [
                RaisedButton(
                  onPressed: () {
                    _menuBloc.foodImagePickerFromCamera();
                  },
                  child: Text("Take Picture"),
                ),
                RaisedButton(
                  onPressed: () {
                    _menuBloc.foodImagePickerFromPhone();
                  },
                  child: Text("Select Picture"),
                )
              ],
            ),
            Row(
              children: [
                Row(
                  children: [
                    Text("Available"),
                    StreamBuilder<bool>(
                        stream: _menuBloc.isAvailable,
                        builder: (context, snapshot) {
                          return Switch(
                            value: snapshot.data,
                            onChanged: _menuBloc.changeAvaibility,
                          );
                        }),
                  ],
                ),
                Row(
                  children: [
                    Text("Hot & New"),
                    StreamBuilder<bool>(
                        stream: _menuBloc.isHotAndNew,
                        builder: (context, snapshot) {
                          return Switch(
                            value: snapshot.data,
                            onChanged: _menuBloc.changeStatus,
                          );
                        }),
                  ],
                )
              ],
            ),
            StreamBuilder<String>(
                stream: _menuBloc.itemName,
                builder: (context, snapshot) {
                  return TextField(
                    controller: widget.job == "update" ? _nameController : null,
                    onChanged: _menuBloc.changeItemName,
                    decoration: InputDecoration(labelText: "Name"),
                  );
                }),
            StreamBuilder<String>(
                stream: _menuBloc.itemPrice,
                builder: (context, snapshot) {
                  return TextField(
                    controller:
                        widget.job == "update" ? _priceController : null,
                    keyboardType: TextInputType.number,
                    onChanged: _menuBloc.changeItemPrice,
                    decoration: InputDecoration(labelText: "Price"),
                  );
                }),
            StreamBuilder<String>(
                stream: _menuBloc.selectedCategory,
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
                      return DropdownButton(
                          value: snapshot.data,
                          isExpanded: true,
                          onTap: () {},
                          items: widget.categories
                              .map<DropdownMenuItem<String>>(
                                (String category) => DropdownMenuItem<String>(
                                  value: category,
                                  child: Text(category),
                                ),
                              )
                              .toList(),
                          onChanged: _menuBloc.changeSelectedCategory);
                      break;
                    case ConnectionState.done:
                      return Text("The task has completed");
                      break;
                  }

                  return null;
                }),
            StreamBuilder(
              stream: _menuBloc.isSaving,
              builder: (context, snapshot) {
                return snapshot.data == true
                    ? Center(
                        child: CircularProgressIndicator(),
                      )
                    : widget.job == "update"
                        ? RaisedButton(
                            onPressed: () {
                              _menuBloc.changeSavingStatus(true);
                              _menuBloc
                                  .updateItem(widget.item.createdAt)
                                  .whenComplete(() {
                                Scaffold.of(context).showSnackBar(
                                    SnackBar(content: Text("Item updated")));
                                _menuBloc.changeSavingStatus(false);
                              });
                            },
                            child: Text(
                              "Update",
                            ),
                          )
                        : StreamBuilder(
                            stream: _menuBloc.canAddNewItem(),
                            builder: (context, snapshot) {
                              return RaisedButton(
                                onPressed: snapshot.hasData
                                    ? () {
                                        _menuBloc.changeSavingStatus(true);
                                        _menuBloc
                                            .saveNewItem(widget.vendor)
                                            .whenComplete(() {
                                          _menuBloc.changeSavingStatus(false);
                                          Scaffold.of(context).showSnackBar(
                                              SnackBar(
                                                  content:
                                                      Text("Item updated")));
                                          _menuBloc.changeSavingStatus(false);
                                        });
                                      }
                                    : null,
                                child: Text("Save Item"),
                              );
                            },
                          );
              },
            )
          ],
        ),
      ),
    );
  }
}
