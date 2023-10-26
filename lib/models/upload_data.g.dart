// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'upload_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$UploadDataImpl _$$UploadDataImplFromJson(Map<String, dynamic> json) =>
    _$UploadDataImpl(
      url: json['url'] as String?,
      fields: (json['fields'] as Map<String, dynamic>?)?.map(
        (k, e) => MapEntry(k, e as String),
      ),
    );

Map<String, dynamic> _$$UploadDataImplToJson(_$UploadDataImpl instance) =>
    <String, dynamic>{
      'url': instance.url,
      'fields': instance.fields,
    };
