<!--
This README describes the package. If you publish this package to pub.dev,
this README's contents appear on the landing page for your package.

For information about how to write a good package README, see the guide for
[writing package pages](https://dart.dev/guides/libraries/writing-package-pages).

For general information about developing packages, see the Dart guide for
[creating packages](https://dart.dev/guides/libraries/create-library-packages)
and the Flutter guide for
[developing packages and plugins](https://flutter.dev/developing-packages).
-->

### Config:
<br>
Flutter Version - 3.13.6
<br>
Dart Version    - 3.1.3
<br>



## Features

A simple package to upload file to amazon S3

## Getting started

Flutter >1.17.0<br>
Dart >=3.0.5 && <4.0.0

## Usage

import package and call uploadSelectedFile method.

```dart
final upload = S3Upload();

FilePickerResult? result = await FilePicker.platform.pickFiles();
File? file;
if (result != null) {
file = File(result.files.single.path);
} else {
// User canceled the picker
}

UploadData uploadData = UploadData(
  url: 'https://mytestbucket.s3.amazonaws.com/',
  fields: {
    "key": "inputdata/user1/myDataFile.xlsx",
    "AWSAccessKeyId": "ASIAABCXXXXXXXXXXXX",
    "x-amz-security-token": "abcxyzloremipsum",
    "policy": "abcxyzloremipsum",
    "signature": "abcxyzloremipsum",
  },
);
if(file!=null){
await upload.uploadSelectFile(uploadData:uploadData,selectFile:file);
}

```

## Additional information

This package is based on the article written by [Suat Özkaya](https://medium.com/@suatozkaya/uploading-files-to-aws-s3-bucket-with-presigned-urls-in-flutter-dart-fd9ffcf82a74)

