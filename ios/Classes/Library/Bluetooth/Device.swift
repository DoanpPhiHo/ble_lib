//
//  Device.swift
//  ble_lib
//
//  Created by Doan Ho on 14/04/2023.
//

import Foundation
import CoreBluetooth

// MARK: - BluetoothDevice
public protocol BluetoothDevice {
    
    var uuidString: String { get }
}

// MARK: - Implementations
extension CBPeripheral: BluetoothDevice {
    
    public var uuidString: String {
        identifier.uuidString
    }
}
