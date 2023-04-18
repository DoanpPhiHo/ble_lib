import Flutter
import CoreBluetooth
import Combine

@available(iOS 14.0, *)
public class BleLibPlugin: NSObject, FlutterPlugin {
    let statusHandle = StatusHandle()
    let scanningHandle = ScanningHandle()
    @Published var state : BleLibPlugin.State = .unknown
    private var cancelable = Set<AnyCancellable>()
    let bluetooth = Bluetooth()
    public static func register(with registrar: FlutterPluginRegistrar) {
        let channel = FlutterMethodChannel(name: "ble_lib", binaryMessenger: registrar.messenger())
        let instance = BleLibPlugin()
        FlutterEventChannel(name: "ble_lib/status", binaryMessenger: registrar.messenger()).setStreamHandler(instance.statusHandle)
        FlutterEventChannel(name: "ble_lib/scanning", binaryMessenger: registrar.messenger()).setStreamHandler(instance.scanningHandle)
        registrar.addMethodCallDelegate(instance, channel: channel)
        registrar.addApplicationDelegate(instance)
    }
    
    public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        result("iOS " + UIDevice.current.systemVersion)
    }
    
    public override init() {
        super.init()
        self.bluetooth.turnOnBluetoothRadio().map{ BleLibPlugin.State(cbState: $0) }
            .sink{ self.statusHandle.sendData($0) }
            .store(in: &cancelable)
        self.bluetooth.$isScanning
            .sink{ self.scanningHandle.sendData($0) }
            .store(in: &cancelable)
    }
}

@available(iOS 14.0, *)
extension BleLibPlugin {
    enum State: String {
        case unknown = "Bluetooth State is unknownn"
        case resetting = "Resetting..."
        case unsupported = "Bluetooth is unsupported on this device"
        case unauthorized = "Bluetooth is unauthorized. Open system settings and grant permissions to use all features of the app"
        case poweredOff = "Bluetooth is powered OFF"
        case poweredOn = "Powered ON"
        
        init(cbState: CBManagerState) {
            switch cbState {
            case .unknown:
                self = .unknown
            case .resetting:
                self = .resetting
            case .unsupported:
                self = .unsupported
            case .unauthorized:
                self = .unauthorized
            case .poweredOff:
                self = .poweredOff
            case .poweredOn:
                self = .poweredOn
            @unknown default:
                fatalError()
            }
        }
    }
}
