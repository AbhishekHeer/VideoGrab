import 'dart:developer';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

class PermissionHandler {
  Future<bool> permission(BuildContext context) async {
    DeviceInfoPlugin plugin = DeviceInfoPlugin();
    final android = await plugin.androidInfo;
    log(android.version.release.toString());
    log(android.version.sdkInt.toString());
    if (android.version.sdkInt < 33) {
      PermissionStatus status = await Permission.storage.request();
      if (status.isGranted) {
        return true;
      } else {
        return false;
      }
    } else {
      PermissionStatus status =
          await Permission.manageExternalStorage.request();
      if (status.isGranted) {
        return true;
      } else {
        return false;
      }
    }
  }
}
