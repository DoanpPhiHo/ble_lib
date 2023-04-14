import 'package:flutter_test/flutter_test.dart';
import 'package:ble_lib/ble_lib.dart';
import 'package:ble_lib/ble_lib_platform_interface.dart';
import 'package:ble_lib/ble_lib_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockBleLibPlatform
    with MockPlatformInterfaceMixin
    implements BleLibPlatform {

  @override
  Future<String?> getPlatformVersion() => Future.value('42');
}

void main() {
  final BleLibPlatform initialPlatform = BleLibPlatform.instance;

  test('$MethodChannelBleLib is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelBleLib>());
  });

  test('getPlatformVersion', () async {
    BleLib bleLibPlugin = BleLib();
    MockBleLibPlatform fakePlatform = MockBleLibPlatform();
    BleLibPlatform.instance = fakePlatform;

    expect(await bleLibPlugin.getPlatformVersion(), '42');
  });
}
