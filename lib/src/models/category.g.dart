// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'category.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<ItemCategory> _$itemCategorySerializer =
    new _$ItemCategorySerializer();

class _$ItemCategorySerializer implements StructuredSerializer<ItemCategory> {
  @override
  final Iterable<Type> types = const [ItemCategory, _$ItemCategory];
  @override
  final String wireName = 'ItemCategory';

  @override
  Iterable<Object> serialize(Serializers serializers, ItemCategory object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[];
    if (object.name != null) {
      result
        ..add('name')
        ..add(serializers.serialize(object.name,
            specifiedType: const FullType(String)));
    }
    if (object.photoURI != null) {
      result
        ..add('photoURI')
        ..add(serializers.serialize(object.photoURI,
            specifiedType: const FullType(String)));
    }
    return result;
  }

  @override
  ItemCategory deserialize(Serializers serializers, Iterable<Object> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new ItemCategoryBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final dynamic value = iterator.current;
      switch (key) {
        case 'name':
          result.name = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'photoURI':
          result.photoURI = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
      }
    }

    return result.build();
  }
}

class _$ItemCategory extends ItemCategory {
  @override
  final String name;
  @override
  final String photoURI;

  factory _$ItemCategory([void Function(ItemCategoryBuilder) updates]) =>
      (new ItemCategoryBuilder()..update(updates)).build();

  _$ItemCategory._({this.name, this.photoURI}) : super._();

  @override
  ItemCategory rebuild(void Function(ItemCategoryBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  ItemCategoryBuilder toBuilder() => new ItemCategoryBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is ItemCategory &&
        name == other.name &&
        photoURI == other.photoURI;
  }

  @override
  int get hashCode {
    return $jf($jc($jc(0, name.hashCode), photoURI.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('ItemCategory')
          ..add('name', name)
          ..add('photoURI', photoURI))
        .toString();
  }
}

class ItemCategoryBuilder
    implements Builder<ItemCategory, ItemCategoryBuilder> {
  _$ItemCategory _$v;

  String _name;
  String get name => _$this._name;
  set name(String name) => _$this._name = name;

  String _photoURI;
  String get photoURI => _$this._photoURI;
  set photoURI(String photoURI) => _$this._photoURI = photoURI;

  ItemCategoryBuilder();

  ItemCategoryBuilder get _$this {
    if (_$v != null) {
      _name = _$v.name;
      _photoURI = _$v.photoURI;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(ItemCategory other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$ItemCategory;
  }

  @override
  void update(void Function(ItemCategoryBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$ItemCategory build() {
    final _$result =
        _$v ?? new _$ItemCategory._(name: name, photoURI: photoURI);
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
