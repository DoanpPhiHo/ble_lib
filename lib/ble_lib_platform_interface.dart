import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'ble_lib_method_channel.dart';

abstract class BleLibPlatform extends PlatformInterface {
  /// Constructs a BleLibPlatform.
  BleLibPlatform() : super(token: _token);

  static final Object _token = Object();

  static BleLibPlatform _instance = MethodChannelBleLib();

  /// The default instance of [BleLibPlatform] to use.
  ///
  /// Defaults to [MethodChannelBleLib].
  static BleLibPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [BleLibPlatform] when
  /// they register themselves.
  static set instance(BleLibPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }
}
