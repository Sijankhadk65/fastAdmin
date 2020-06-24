import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:built_collection/built_collection.dart';
import 'package:fastibtmsadmin/src/models/serializer.dart';

part 'vendor.g.dart';

abstract class Vendor implements Built<Vendor, VendorBuilder> {
  @nullable
  String get name;
  @nullable
  String get photoURI;
  @nullable
  String get closeTime;
  @nullable
  String get openTime;
  @nullable
  int get minOrder;
  @nullable
  String get location;
  @nullable
  BuiltList<String> get tags;
  @nullable
  BuiltList<String> get categories;
  @nullable
  bool get isBusy;
  @nullable
  double get lat;
  @nullable
  double get lang;

  factory Vendor([void Function(VendorBuilder) updates]) = _$Vendor;
  Vendor._();
  static Serializer<Vendor> get serializer => _$vendorSerializer;
}

Vendor parseJsonToVendor(Map<String, dynamic> json) {
  return jsonSerializer.deserializeWith(Vendor.serializer, json);
}
