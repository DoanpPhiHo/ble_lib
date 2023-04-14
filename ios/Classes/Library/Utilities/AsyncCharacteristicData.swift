//
//  AsyncCharacteristicData.swift
//  ble_lib
//
//  Created by Doan Ho on 14/04/2023.
//

import Foundation
import CoreBluetooth

public typealias AsyncStreamValue = (characteristic: CBCharacteristic, data: Data?)

@available(iOS 13.0, *)
public struct AsyncCharacteristicData: AsyncSequence, AsyncIteratorProtocol {
    public typealias Element = Data?
    
    let serviceUUID: String
    let characteristicUUID: String
    let stream: AsyncThrowingStream<AsyncStreamValue, Error>

    public func makeAsyncIterator() -> AsyncCharacteristicData {
        self
    }
    
    mutating public func next() async throws -> Element? {
        for try await newValue in stream {
            guard newValue.characteristic.uuid.uuidString == characteristicUUID,
                  let service = newValue.characteristic.service,
                  service.uuid.uuidString == serviceUUID else { continue }
            return newValue.data
        }
        return nil
    }
}
