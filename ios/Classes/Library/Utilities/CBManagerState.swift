//
//  CBManagerState.swift
//  ble_lib
//
//  Created by Doan Ho on 14/04/2023.
//

import Foundation
import CoreBluetooth

// MARK: - CBManagerState
extension CBManagerState: CustomDebugStringConvertible, CustomStringConvertible {
    
    public var debugDescription: String {
        return description
    }
    
    public var description: String {
        switch self {
        case .poweredOff:
            return "poweredOff"
        case .poweredOn:
            return "poweredOn"
        case .resetting:
            return "resetting"
        case .unauthorized:
            return "unauthorized"
        case .unknown:
            return "unknown"
        case .unsupported:
            return "unsupported"
        @unknown default:
            return "unknownState"
        }
    }
}
