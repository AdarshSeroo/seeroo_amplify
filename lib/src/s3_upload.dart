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

  Map changeConfig({required String bucket, required String region}) {
    Map map = {
      "UserAgent": "aws-amplify-cli/2.0",
      "Version": "1.0",
      "auth": {
        "plugins": {
          "awsCognitoAuthPlugin": {
            "UserAgent": "aws-amplify-cli/0.1.0",
            "Version": "0.1.0",
            "IdentityManager": {"Default": {}},
            "CredentialsProvider": {
              "CognitoIdentity": {
                "Default": {
                  "PoolId": "me-south-1:e4de7b2f-756c-4b03-8029-91c0a7eaf1b9",
                  "Region": "me-south-1"
                }
              }
            },
            "CognitoUserPool": {
              "Default": {
                "PoolId": "me-south-1_GiSo5IuLt",
                "AppClientId": "2mgqoan42vlntsf103prrdm2f0",
                "Region": "me-south-1"
              }
            },
            "Auth": {
              "Default": {
                "authenticationFlowType": "USER_SRP_AUTH",
                "mfaConfiguration": "OFF",
                "mfaTypes": ["SMS"],
                "passwordProtectionSettings": {
                  "passwordPolicyMinLength": 8,
                  "passwordPolicyCharacters": []
                },
                "signupAttributes": ["EMAIL"],
                "socialProviders": [],
                "usernameAttributes": [],
                "verificationMechanisms": ["EMAIL"]
              }
            },
            "S3TransferUtility": {
              "Default": {"Bucket": bucket, "Region": region}
            }
          }
        }
      },
      "storage": {
        "plugins": {
          "awsS3StoragePlugin": {
            "bucket": bucket,
            "region": region,
            "defaultAccessLevel": "guest"
          }
        }
      }
    };
    return map;
  }

  Future<StorageItem?> uploadFile({
    required PlatformFile selectedFile,
    required String fileType,
    bool isFileUpload = false,
    bool isDefaultBucket = true,
    String? customBucketName,
    required String fileKey,
    String? region,
    void Function(StorageTransferProgress)? onTransfer,
  }) async {
    try {
      late StorageItem item;
      String key = fileKey;
      key += DateTime.now().toString();
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
}