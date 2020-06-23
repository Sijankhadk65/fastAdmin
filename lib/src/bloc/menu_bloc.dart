import 'dart:io';

import 'package:fastibtmsadmin/src/models/category.dart';
import 'package:fastibtmsadmin/src/models/menu_item.dart';
import 'package:fastibtmsadmin/src/resources/repository.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import 'package:rxdart/rxdart.dart';

class MenuBloc {
  final _repo = Repository();
  List<ItemCategory> itemCategories = [];
  final BehaviorSubject<List<String>> _categoriesSubject =
      BehaviorSubject<List<String>>();
  Stream<List<String>> get categories => _categoriesSubject.stream;
  Function(List<String>) get changeCategories => _categoriesSubject.sink.add;

  final BehaviorSubject<List<MenuItem>> _menuItemsSubject =
      BehaviorSubject<List<MenuItem>>();
  Stream<List<MenuItem>> get menuItems => _menuItemsSubject.stream;
  Function(List<MenuItem>) get changeMenuItems => _menuItemsSubject.sink.add;

  // For Adding new menu Item

  final BehaviorSubject<String> _itemNameSubject = BehaviorSubject<String>();
  Stream<String> get itemName => _itemNameSubject.stream;
  Function(String) get changeItemName => _itemNameSubject.sink.add;

  final BehaviorSubject<String> _itemPriceSubject = BehaviorSubject<String>();
  Stream<String> get itemPrice => _itemPriceSubject.stream;
  Function(String) get changeItemPrice => _itemPriceSubject.sink.add;

  final BehaviorSubject<bool> _isAvailableSubject = BehaviorSubject<bool>();
  Stream<bool> get isAvailable => _isAvailableSubject.stream;
  Function(bool) get changeAvaibility => _isAvailableSubject.sink.add;

  final BehaviorSubject<bool> _isHotAndNewSubject = BehaviorSubject<bool>();
  Stream<bool> get isHotAndNew => _isHotAndNewSubject.stream;
  Function(bool) get changeStatus => _isHotAndNewSubject.sink.add;

  final BehaviorSubject<String> _selectedCategorySubject =
      BehaviorSubject<String>();
  Stream<String> get selectedCategory => _selectedCategorySubject.stream;
  Function(String) get changeSelectedCategory =>
      _selectedCategorySubject.sink.add;

  final BehaviorSubject<bool> _isSavingSubject = BehaviorSubject<bool>();
  Stream<bool> get isSaving => _isSavingSubject.stream;
  Function(bool) get changeSavingStatus => _isSavingSubject.sink.add;

  // This is for the path of the image
  final BehaviorSubject<String> _imagepathSubject = BehaviorSubject<String>();
  Stream<String> get imagepath => _imagepathSubject.stream;
  Function(String) get changeImagePath => _imagepathSubject.sink.add;

  MenuBloc() {
    changeAvaibility(true);
    changeStatus(true);
    changeSavingStatus(false);
  }

  getMenuItems(String category, String vendor) {
    _repo.getMenuItems(category, vendor).listen((items) {
      changeMenuItems(items);
    });
  }

  Stream<bool> canAddNewItem() =>
      Rx.combineLatest3(itemName, itemPrice, imagepath, (a, b, c) => true);
  Future<void> saveNewItem(String vendor) async {
    final _imageTask = await _repo.savePhoto(File(_imagepathSubject.value),
        basename(File(_imagepathSubject.value).path));
    if (_imageTask.error != null) return;
    final downloadString = await _imageTask.ref.getDownloadURL();
    return _repo.saveNewItem(
      {
        "name": _itemNameSubject.value,
        "price": int.parse(_itemPriceSubject.value),
        "photoURI": downloadString,
        "category": _selectedCategorySubject.value,
        "isAvailable": _isAvailableSubject.value,
        "isHotAndNew": _isHotAndNewSubject.value,
        "vendor": vendor,
        "createdAt": DateTime.now().toIso8601String(),
      },
    );
  }

  // For Adding images

  foodImagePickerFromPhone() async {
    final _picker = ImagePicker();
    final _galleryImage = await _picker.getImage(source: ImageSource.gallery);
    changeImagePath(_galleryImage.path);
  }

  foodImagePickerFromCamera() async {
    final _picker = ImagePicker();
    final _galleryImage = await _picker.getImage(source: ImageSource.camera);
    changeImagePath(_galleryImage.path);
  }

  // for adding categories

  final BehaviorSubject<String> _categorySubject = BehaviorSubject<String>();
  Stream<String> get category => _categorySubject.stream;
  Function(String) get changeCategory => _categorySubject.sink.add;

  Stream<bool> canSaveNewCategory() =>
      Rx.combineLatest2(category, imagepath, (a, b) => true);

  Future<void> saveNewCategory() async {
    final _imageTask = await _repo.savePhoto(File(_imagepathSubject.value),
        basename(File(_imagepathSubject.value).path));
    if (_imageTask.error != null) return;
    final downloadString = await _imageTask.ref.getDownloadURL();
    return _repo.saveNewCategory({
      "name": _categorySubject.value,
      "photoURI": downloadString,
    });
  }

  getItemAvaibility(String createdAt) {
    _repo.getItemAvaibility(createdAt).listen((event) {
      changeAvaibility(event);
    });
  }

  updateAvaibility(bool value, String createdAt) =>
      _repo.changeAvaibility(value, createdAt);

  Future<void> updateItem(String createdAt) async {
    var newData = {
      "name": _itemNameSubject.value,
      "price": int.parse(_itemPriceSubject.value),
      "category": _selectedCategorySubject.value,
      "isAvailable": _isAvailableSubject.value,
      "isHotAndNew": _isHotAndNewSubject.value,
    };
    print("The data $newData");
  }

  void dispose() {
    _menuItemsSubject.close();
    _categoriesSubject.close();
    _itemNameSubject.close();
    _itemPriceSubject.close();
    _isAvailableSubject.close();
    _isHotAndNewSubject.close();
    _selectedCategorySubject.close();
    _imagepathSubject.close();
    _categoriesSubject.close();
    _categorySubject.close();
    _isSavingSubject.close();
  }
}
