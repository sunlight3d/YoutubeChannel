// lib/utils/device_utils.dart

import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:device_info_plus/device_info_plus.dart';

Future<String> getDeviceId() async {
  String? deviceId;
  final DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();

  if (kIsWeb) {
    final WebBrowserInfo webBrowserInfo = await deviceInfoPlugin.webBrowserInfo;
    deviceId = webBrowserInfo.userAgent;
  } else {
    if (Platform.isAndroid) {
      final AndroidDeviceInfo androidInfo = await deviceInfoPlugin.androidInfo;
      deviceId = androidInfo.id;
    } else if (Platform.isIOS) {
      final IosDeviceInfo iosInfo = await deviceInfoPlugin.iosInfo;
      deviceId = iosInfo.identifierForVendor;
    } else if (Platform.isLinux) {
      final LinuxDeviceInfo linuxInfo = await deviceInfoPlugin.linuxInfo;
      deviceId = linuxInfo.machineId;
    } else if (Platform.isMacOS) {
      final MacOsDeviceInfo macOsInfo = await deviceInfoPlugin.macOsInfo;
      deviceId = macOsInfo.systemGUID;
    } else if (Platform.isWindows) {
      final WindowsDeviceInfo windowsInfo = await deviceInfoPlugin.windowsInfo;
      deviceId = windowsInfo.deviceId;
    } else {
      throw Exception('Platform not supported');
    }
  }
  return deviceId ?? "";
}
