// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'vendor.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<Vendor> _$vendorSerializer = new _$VendorSerializer();

class _$VendorSerializer implements StructuredSerializer<Vendor> {
  @override
  final Iterable<Type> types = const [Vendor, _$Vendor];
  @override
  final String wireName = 'Vendor';

  @override
  Iterable<Object> serialize(Serializers serializers, Vendor object,
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
    if (object.closeTime != null) {
      result
        ..add('closeTime')
        ..add(serializers.serialize(object.closeTime,
            specifiedType: const FullType(String)));
    }
    if (object.openTime != null) {
      result
        ..add('openTime')
        ..add(serializers.serialize(object.openTime,
            specifiedType: const FullType(String)));
    }
    if (object.minOrder != null) {
      result
        ..add('minOrder')
        ..add(serializers.serialize(object.minOrder,
            specifiedType: const FullType(int)));
    }
    if (object.location != null) {
      result
        ..add('location')
        ..add(serializers.serialize(object.location,
            specifiedType: const FullType(String)));
    }
    if (object.tags != null) {
      result
        ..add('tags')
        ..add(serializers.serialize(object.tags,
            specifiedType:
                const FullType(BuiltList, const [const FullType(String)])));
    }
    if (object.categories != null) {
      result
        ..add('categories')
        ..add(serializers.serialize(object.categories,
            specifiedType:
                const FullType(BuiltList, const [const FullType(String)])));
    }
    if (object.isBusy != null) {
      result
        ..add('isBusy')
        ..add(serializers.serialize(object.isBusy,
            specifiedType: const FullType(bool)));
    }
    return result;
  }

  @override
  Vendor deserialize(Serializers serializers, Iterable<Object> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new VendorBuilder();

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
        case 'closeTime':
          result.closeTime = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'openTime':
          result.openTime = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'minOrder':
          result.minOrder = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
        case 'location':
          result.location = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'tags':
          result.tags.replace(serializers.deserialize(value,
                  specifiedType:
                      const FullType(BuiltList, const [const FullType(String)]))
              as BuiltList<Object>);
          break;
        case 'categories':
          result.categories.replace(serializers.deserialize(value,
                  specifiedType:
                      const FullType(BuiltList, const [const FullType(String)]))
              as BuiltList<Object>);
          break;
        case 'isBusy':
          result.isBusy = serializers.deserialize(value,
              specifiedType: const FullType(bool)) as bool;
          break;
      }
    }

    return result.build();
  }
}

class _$Vendor extends Vendor {
  @override
  final String name;
  @override
  final String photoURI;
  @override
  final String closeTime;
  @override
  final String openTime;
  @override
  final int minOrder;
  @override
  final String location;
  @override
  final BuiltList<String> tags;
  @override
  final BuiltList<String> categories;
  @override
  final bool isBusy;

  factory _$Vendor([void Function(VendorBuilder) updates]) =>
      (new VendorBuilder()..update(updates)).build();

  _$Vendor._(
      {this.name,
      this.photoURI,
      this.closeTime,
      this.openTime,
      this.minOrder,
      this.location,
      this.tags,
      this.categories,
      this.isBusy})
      : super._();

  @override
  Vendor rebuild(void Function(VendorBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  VendorBuilder toBuilder() => new VendorBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is Vendor &&
        name == other.name &&
        photoURI == other.photoURI &&
        closeTime == other.closeTime &&
        openTime == other.openTime &&
        minOrder == other.minOrder &&
        location == other.location &&
        tags == other.tags &&
        categories == other.categories &&
        isBusy == other.isBusy;
  }

  @override
  int get hashCode {
    return $jf($jc(
        $jc(
            $jc(
                $jc(
                    $jc(
                        $jc(
                            $jc($jc($jc(0, name.hashCode), photoURI.hashCode),
                                closeTime.hashCode),
                            openTime.hashCode),
                        minOrder.hashCode),
                    location.hashCode),
                tags.hashCode),
            categories.hashCode),
        isBusy.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('Vendor')
          ..add('name', name)
          ..add('photoURI', photoURI)
          ..add('closeTime', closeTime)
          ..add('openTime', openTime)
          ..add('minOrder', minOrder)
          ..add('location', location)
          ..add('tags', tags)
          ..add('categories', categories)
          ..add('isBusy', isBusy))
        .toString();
  }
}

class VendorBuilder implements Builder<Vendor, VendorBuilder> {
  _$Vendor _$v;

  String _name;
  String get name => _$this._name;
  set name(String name) => _$this._name = name;

  String _photoURI;
  String get photoURI => _$this._photoURI;
  set photoURI(String photoURI) => _$this._photoURI = photoURI;

  String _closeTime;
  String get closeTime => _$this._closeTime;
  set closeTime(String closeTime) => _$this._closeTime = closeTime;

  String _openTime;
  String get openTime => _$this._openTime;
  set openTime(String openTime) => _$this._openTime = openTime;

  int _minOrder;
  int get minOrder => _$this._minOrder;
  set minOrder(int minOrder) => _$this._minOrder = minOrder;

  String _location;
  String get location => _$this._location;
  set location(String location) => _$this._location = location;

  ListBuilder<String> _tags;
  ListBuilder<String> get tags => _$this._tags ??= new ListBuilder<String>();
  set tags(ListBuilder<String> tags) => _$this._tags = tags;

  ListBuilder<String> _categories;
  ListBuilder<String> get categories =>
      _$this._categories ??= new ListBuilder<String>();
  set categories(ListBuilder<String> categories) =>
      _$this._categories = categories;

  bool _isBusy;
  bool get isBusy => _$this._isBusy;
  set isBusy(bool isBusy) => _$this._isBusy = isBusy;

  VendorBuilder();

  VendorBuilder get _$this {
    if (_$v != null) {
      _name = _$v.name;
      _photoURI = _$v.photoURI;
      _closeTime = _$v.closeTime;
      _openTime = _$v.openTime;
      _minOrder = _$v.minOrder;
      _location = _$v.location;
      _tags = _$v.tags?.toBuilder();
      _categories = _$v.categories?.toBuilder();
      _isBusy = _$v.isBusy;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(Vendor other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$Vendor;
  }

  @override
  void update(void Function(VendorBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$Vendor build() {
    _$Vendor _$result;
    try {
      _$result = _$v ??
          new _$Vendor._(
              name: name,
              photoURI: photoURI,
              closeTime: closeTime,
              openTime: openTime,
              minOrder: minOrder,
              location: location,
              tags: _tags?.build(),
              categories: _categories?.build(),
              isBusy: isBusy);
    } catch (_) {
      String _$failedField;
      try {
        _$failedField = 'tags';
        _tags?.build();
        _$failedField = 'categories';
        _categories?.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            'Vendor', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
