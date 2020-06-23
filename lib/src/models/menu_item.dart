import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:fastibtmsadmin/src/models/serializer.dart';

part 'menu_item.g.dart';

abstract class MenuItem implements Built<MenuItem, MenuItemBuilder> {
  @nullable
  String get name;
  @nullable
  int get price;
  @nullable
  String get photoURI;
  @nullable
  String get category;
  @nullable
  bool get isAvailable;
  @nullable
  String get createdAt;

  factory MenuItem([void Function(MenuItemBuilder) updates]) = _$MenuItem;
  MenuItem._();
  static Serializer<MenuItem> get serializer => _$menuItemSerializer;
}

MenuItem parseJsonToMenuItem(Map<String, dynamic> json) {
  return jsonSerializer.deserializeWith(MenuItem.serializer, json);
}
