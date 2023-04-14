import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'ble_lib_platform_interface.dart';

/// An implementation of [BleLibPlatform] that uses method channels.
class MethodChannelBleLib extends BleLibPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('ble_lib');

  @override
  Future<String?> getPlatformVersion() async {
    final version = await methodChannel.invokeMethod<String>('getPlatformVersion');
    return version;
  }
}
