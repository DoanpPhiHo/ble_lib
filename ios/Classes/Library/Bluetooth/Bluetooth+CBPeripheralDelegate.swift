//
//  Bluetooth+CBPeripheralDelegate.swift
//  ble_lib
//
//  Created by Doan Ho on 14/04/2023.
//

import Foundation
import CoreBluetooth

// MARK: - CBPeripheralDelegate
@available(iOS 14.0, *)
extension Bluetooth: CBPeripheralDelegate {
    
    public func peripheral(_ peripheral: CBPeripheral, didDiscoverServices error: Error?) {
        logger.debug("[Callback] peripheral(peripheral: \(peripheral), didDiscoverServices error: \(error.debugDescription))")
        guard case .serviceDiscovery(let continuation)? = continuations[peripheral.identifier.uuidString] else { return }
        if let error = error {
            continuation.resume(throwing: BluetoothError(error))
        } else {
            // Success.
            continuation.resume(returning: peripheral)
        }
    }
    
    public func peripheral(_ peripheral: CBPeripheral, didDiscoverCharacteristicsFor service: CBService, error: Error?) {
        logger.debug("[Callback] peripheral(peripheral: \(peripheral), didDiscoverCharacteristicsFor: \(service), error: \(error.debugDescription))")
        guard case .updatedService(let continuation)? = continuations[peripheral.identifier.uuidString] else { return }
        if let error = error {
            continuation.resume(throwing: BluetoothError(error))
        } else {
            // Success.
            continuation.resume(returning: service)
        }
    }
    
    public func peripheral(_ peripheral: CBPeripheral, didWriteValueFor characteristic: CBCharacteristic, error: Error?) {
        logger.debug("[Callback] peripheral(peripheral: \(peripheral), didWriteValueFor: \(characteristic), error: \(error.debugDescription))")
        guard case .attribute(let continuation)? = continuations[peripheral.identifier.uuidString] else { return }
        if let error = error {
            continuation.resume(throwing: BluetoothError(error))
        } else {
            continuation.resume(returning: characteristic.value)
        }
    }
    
    public func peripheral(_ peripheral: CBPeripheral, didUpdateNotificationStateFor characteristic: CBCharacteristic, error: Error?) {
        logger.debug("[Callback] peripheral(peripheral: \(peripheral), didUpdateNotificationStateFor: \(characteristic), error: \(error.debugDescription))")
        guard case .notificationChange(let continuation)? = continuations[peripheral.identifier.uuidString] else { return }
        if let error = error {
            continuation.resume(throwing: BluetoothError(error))
        } else {
            continuation.resume(returning: characteristic.isNotifying)
        }
    }
    
    public func peripheral(_ peripheral: CBPeripheral, didUpdateValueFor characteristic: CBCharacteristic, error: Error?) {
        logger.debug("[Callback] peripheral(peripheral: \(peripheral), didUpdateValueFor: \(characteristic), error: \(error.debugDescription))")
        if let error = error {
            reportDataStreamError(BluetoothError(error), for: peripheral)
        } else {
            dataStreams[peripheral.identifier.uuidString]?.forEach {
                $0.yield((characteristic, characteristic.value))
            }
        }
    }
}
