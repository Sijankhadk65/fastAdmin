library serializers;

import 'package:built_value/serializer.dart';
import 'package:built_collection/built_collection.dart';
import 'package:built_value/standard_json_plugin.dart';
import 'package:fastibtmsadmin/src/models/cart_item.dart';
import 'package:fastibtmsadmin/src/models/category.dart';
import 'package:fastibtmsadmin/src/models/online_order.dart';
import 'package:fastibtmsadmin/src/models/user.dart';
import 'package:fastibtmsadmin/src/models/vendor.dart';
import 'menu_item.dart';

part 'serializer.g.dart';

@SerializersFor(
    const [User, MenuItem, ItemCategory, OnlineOrder, CartItem, Vendor])
final Serializers serializers = _$serializers;
final jsonSerializer =
    (serializers.toBuilder()..addPlugin(StandardJsonPlugin())).build();
