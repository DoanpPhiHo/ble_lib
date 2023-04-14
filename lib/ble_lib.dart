
import 'ble_lib_platform_interface.dart';

class BleLib {
  Future<String?> getPlatformVersion() {
    return BleLibPlatform.instance.getPlatformVersion();
  }
}
