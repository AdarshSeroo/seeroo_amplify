import 'package:freezed_annotation/freezed_annotation.dart';

part 'upload_data.freezed.dart';
part 'upload_data.g.dart';

@freezed
class UploadData with _$UploadData {
  ///[url] should not be null submitting null will result in exception
  ///
  ///[fields] should not be null submitting null will result in exception
  ///
  ///[url] is the aws url
  ///
  /// add keys,aws access key id,security token etc in fields [fields]
  ///
  ///
  /// eg:
  ///
  ///
  /// UploadData uploadData = UploadData(
  ///
  /// url: 'https://mytestbucket.s3.amazonaws.com/',
  ///
  ///   fields: {
  ///     "key": "inputdata/user1/myDataFile.xlsx",
  ///     "AWSAccessKeyId": "ASIAABCXXXXXXXXXXXX",
  ///     "x-amz-security-token": "abcxyzloremipsum",
  ///     "policy": "abcxyzloremipsum",
  ///     "signature": "abcxyzloremipsum",
  ///   },
  /// );
  const factory UploadData({
    final String? url,
    final Map<String, String>? fields,
  }) = _UploadData;

  factory UploadData.fromJson(Map<String, dynamic> json) =>
      _$UploadDataFromJson(json);
}
