import 'dart:io';

import 'package:fastibtmsadmin/src/bloc/category_bloc.dart';
import 'package:fastibtmsadmin/src/bloc/menu_bloc.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddCategoriesScreen extends StatefulWidget {
  @override
  _AddCategoriesScreenState createState() => _AddCategoriesScreenState();
}

class _AddCategoriesScreenState extends State<AddCategoriesScreen> {
  CategoryBloc _menuBloc;

  @override
  void didChangeDependencies() {
    _menuBloc = Provider.of<CategoryBloc>(context);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        child: Column(
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
            StreamBuilder<String>(
                stream: _menuBloc.category,
                builder: (context, snapshot) {
                  return TextField(
                    onChanged: _menuBloc.changeCategory,
                    decoration: InputDecoration(labelText: "Category Name"),
                  );
                }),
            StreamBuilder<bool>(
                stream: _menuBloc.canSaveNewCategory(),
                builder: (context, snapshot) {
                  print("This snapshot is ${snapshot.data}");
                  return RaisedButton(
                    onPressed: snapshot.hasData
                        ? () {
                            _menuBloc.saveNewCategory();
                          }
                        : null,
                    child: Text("Save"),
                  );
                }),
          ],
        ),
      ),
    );
  }
}
