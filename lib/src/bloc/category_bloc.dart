import 'dart:io';

import 'package:fastibtmsadmin/src/resources/repository.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import 'package:rxdart/rxdart.dart';

class CategoryBloc {
  final _repo = Repository();

  final BehaviorSubject<String> _categorySubject = BehaviorSubject<String>();
  Stream<String> get category => _categorySubject.stream;
  Function(String) get changeCategory => _categorySubject.sink.add;

  // This is for the path of the image
  final BehaviorSubject<String> _imagepathSubject = BehaviorSubject<String>();
  Stream<String> get imagepath => _imagepathSubject.stream;
  Function(String) get changeImagePath => _imagepathSubject.sink.add;

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

  dispose() {
    _imagepathSubject.close();
    _categorySubject.close();
  }
}
