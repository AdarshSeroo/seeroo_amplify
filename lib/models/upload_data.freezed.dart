// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'upload_data.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

UploadData _$UploadDataFromJson(Map<String, dynamic> json) {
  return _UploadData.fromJson(json);
}

/// @nodoc
mixin _$UploadData {
  String? get url => throw _privateConstructorUsedError;
  Map<String, String>? get fields => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $UploadDataCopyWith<UploadData> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UploadDataCopyWith<$Res> {
  factory $UploadDataCopyWith(
          UploadData value, $Res Function(UploadData) then) =
      _$UploadDataCopyWithImpl<$Res, UploadData>;
  @useResult
  $Res call({String? url, Map<String, String>? fields});
}

/// @nodoc
class _$UploadDataCopyWithImpl<$Res, $Val extends UploadData>
    implements $UploadDataCopyWith<$Res> {
  _$UploadDataCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? url = freezed,
    Object? fields = freezed,
  }) {
    return _then(_value.copyWith(
      url: freezed == url
          ? _value.url
          : url // ignore: cast_nullable_to_non_nullable
              as String?,
      fields: freezed == fields
          ? _value.fields
          : fields // ignore: cast_nullable_to_non_nullable
              as Map<String, String>?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$UploadDataImplCopyWith<$Res>
    implements $UploadDataCopyWith<$Res> {
  factory _$$UploadDataImplCopyWith(
          _$UploadDataImpl value, $Res Function(_$UploadDataImpl) then) =
      __$$UploadDataImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String? url, Map<String, String>? fields});
}

/// @nodoc
class __$$UploadDataImplCopyWithImpl<$Res>
    extends _$UploadDataCopyWithImpl<$Res, _$UploadDataImpl>
    implements _$$UploadDataImplCopyWith<$Res> {
  __$$UploadDataImplCopyWithImpl(
      _$UploadDataImpl _value, $Res Function(_$UploadDataImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? url = freezed,
    Object? fields = freezed,
  }) {
    return _then(_$UploadDataImpl(
      url: freezed == url
          ? _value.url
          : url // ignore: cast_nullable_to_non_nullable
              as String?,
      fields: freezed == fields
          ? _value._fields
          : fields // ignore: cast_nullable_to_non_nullable
              as Map<String, String>?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$UploadDataImpl implements _UploadData {
  const _$UploadDataImpl({this.url, final Map<String, String>? fields})
      : _fields = fields;

  factory _$UploadDataImpl.fromJson(Map<String, dynamic> json) =>
      _$$UploadDataImplFromJson(json);

  @override
  final String? url;
  final Map<String, String>? _fields;
  @override
  Map<String, String>? get fields {
    final value = _fields;
    if (value == null) return null;
    if (_fields is EqualUnmodifiableMapView) return _fields;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(value);
  }

  @override
  String toString() {
    return 'UploadData(url: $url, fields: $fields)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UploadDataImpl &&
            (identical(other.url, url) || other.url == url) &&
            const DeepCollectionEquality().equals(other._fields, _fields));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType, url, const DeepCollectionEquality().hash(_fields));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$UploadDataImplCopyWith<_$UploadDataImpl> get copyWith =>
      __$$UploadDataImplCopyWithImpl<_$UploadDataImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$UploadDataImplToJson(
      this,
    );
  }
}

abstract class _UploadData implements UploadData {
  const factory _UploadData(
      {final String? url,
      final Map<String, String>? fields}) = _$UploadDataImpl;

  factory _UploadData.fromJson(Map<String, dynamic> json) =
      _$UploadDataImpl.fromJson;

  @override
  String? get url;
  @override
  Map<String, String>? get fields;
  @override
  @JsonKey(ignore: true)
  _$$UploadDataImplCopyWith<_$UploadDataImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
