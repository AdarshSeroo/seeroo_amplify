import 'dart:developer';
import 'dart:io';

import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:amplify_storage_s3/amplify_storage_s3.dart';
import 'package:aws_common/vm.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:mime/mime.dart';
import 'package:path/path.dart';

class S3Upload {
  ///call this method to upload file to AWS
  ///
  ///[selectedFile],[fileType],[fileKey] are mandatory.
  ///
  ///[selectedFile] : pass file picked by file_picker plugin.
  ///
  /// [fileType] : pass the file type of the file in this field.
  /// This package used mime package under the hood,if the package fails to identify the mimetype value from this field is used.
  ///
  /// [isFileUpload] : if true Amplify.Storage.uploadFile method is used else Amplify.Storage.uploadData is used.
  /// This field is false by default.
  ///
  /// [fileKey] :mandatory field which describes where the file will be stored.
  ///
  /// [onTransfer] : This method is triggered when transfer begins.
  /// Use this to get total bytes of data to be uploaded and current transfer state
  ///
  ///
  ///

  Future<StorageItem?> uploadFile({
    required PlatformFile selectedFile,
    required String fileType,
    bool isFileUpload = false,
    required String fileKey,
    void Function(StorageTransferProgress)? onTransfer,
  }) async {
    try {
      late StorageItem item;
      String key = basename(fileKey);
      // key += DateTime.now().toString();
      Map<String, String> metadata = <String, String>{};
      final (selectedFileBytes, selectedFileName) =
          await _getFileBytesAndName(selectedFile);
      metadata['name'] = selectedFileName;
      String? mimeType =
          lookupMimeType(selectedFileName, headerBytes: selectedFileBytes);
      if (selectedFile.extension != null) {
        key += '.${selectedFile.extension}';
      }

      log("mimeType of selectedFile is $mimeType", name: "SEEROOS3UPLOAD");

      if (isFileUpload) {
        final awsFile = AWSFilePlatform.fromData(selectedFileBytes,
            name: selectedFileName, contentType: mimeType ?? fileType);

        final options = StorageUploadFileOptions(metadata: metadata);

        final StorageUploadFileOperation operation = Amplify.Storage.uploadFile(
            localFile: awsFile,
            key: key,
            options: options,
            onProgress: (progress) {
              log("progress ${progress.transferredBytes}/${progress.totalBytes}",
                  name: "SEEROOS3UPLOAD");
              if (onTransfer != null) {
                onTransfer(progress);
              }
            });

        final uploadFileResult = await operation.result;
        item = uploadFileResult.uploadedItem;
      } else {
        final uploadDataOptions = StorageUploadDataOptions(
            pluginOptions: const S3UploadDataPluginOptions(getProperties: true),
            metadata: metadata);

        final uploadDataOperation = Amplify.Storage.uploadData(
            data: HttpPayload.bytes(selectedFileBytes,
                contentType: mimeType ?? fileType),
            key: key,
            onProgress: (progress) {
              log("progress ${progress.transferredBytes}/${progress.totalBytes}",
                  name: "SEEROOS3UPLOAD");
              if (onTransfer != null) {
                onTransfer(progress);
              }
            },
            options: uploadDataOptions);

        final uploadDataResult = await uploadDataOperation.result;

        item = uploadDataResult.uploadedItem;
      }

      log("uploadFile result is key:${item.key} tag:${item.eTag} lastModified:${item.lastModified} metaData:${item.metadata} size:${item.size}",
          name: "SEEROOS3UPLOAD");
      return item;
    } catch (e, s) {
      log("exception occurred while uploading data $e",
          name: "SEEROOS3UPLOAD", stackTrace: s, error: e, level: 1200);
      return null;
    }
  }

  Future<(List<int>, String)> _getFileBytesAndName(Object? file) async {
    List<int> bytes;
    String fileName;

    if (file is File && kIsWeb == false) {
      bytes = await file.readAsBytes();
      fileName = basename(file.path);
    } else if (file is PlatformFile) {
      if (kIsWeb) {
        bytes = file.bytes!;
      } else {
        bytes = await _getFileBytes(file);
      }
      fileName = file.name;
    } else {
      throw Exception('Invalid file type');
    }
    return (bytes, fileName);
  }

  Future<List<int>> _getFileBytes(PlatformFile platformFile) async {
    // Get the file path from the PlatformFile object
    String? filePath = platformFile.path;

    // Read the file as bytes, File is from the dart:io library
    File file = File(filePath!);
    List<int> fileBytes = await file.readAsBytes();

    return fileBytes;
  }
}
