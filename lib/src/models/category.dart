import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:fastibtmsadmin/src/models/serializer.dart';

part 'category.g.dart';

abstract class ItemCategory
    implements Built<ItemCategory, ItemCategoryBuilder> {
  @nullable
  String get name;
  @nullable
  String get photoURI;

  factory ItemCategory([void Function(ItemCategoryBuilder) updates]) =
      _$ItemCategory;
  ItemCategory._();
  static Serializer<ItemCategory> get serializer => _$itemCategorySerializer;
}

ItemCategory parseJsonToItemCategory(Map<String, dynamic> data) =>
    jsonSerializer.deserializeWith(ItemCategory.serializer, data);
