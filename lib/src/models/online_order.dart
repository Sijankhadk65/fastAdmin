import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:fastibtmsadmin/src/models/cart_item.dart';
import 'package:fastibtmsadmin/src/models/serializer.dart';
import 'package:fastibtmsadmin/src/models/user.dart';

part 'online_order.g.dart';

abstract class OnlineOrder implements Built<OnlineOrder, OnlineOrderBuilder> {
  @nullable
  int get totalPrice;
  @nullable
  User get user;
  @nullable
  String get orderID;
  @nullable
  BuiltList<String> get status;
  @nullable
  String get createdAt;
  @nullable
  String get vendor;
  @nullable
  String get location;
  @nullable
  BuiltList<CartItem> get items;

  OnlineOrder._();
  factory OnlineOrder([updates(OnlineOrderBuilder b)]) = _$OnlineOrder;
  static Serializer<OnlineOrder> get serializer => _$onlineOrderSerializer;
}

OnlineOrder parseJsonToOnlineOrder(Map<String, dynamic> json) =>
    jsonSerializer.deserializeWith(OnlineOrder.serializer, json);
