//
//  DeviceInfo.swift
//  ble_lib
//
//  Created by Doan Ho on 17/04/2023.
//

import Foundation
import CoreBluetooth

struct DeviceInfo: Codable{
    let name:String
    let id:String
    var isConnect:Bool = false
}

class DeviceBle: NSObject{
    var deviceInfo: DeviceInfo
    var peripheral: CBPeripheral? = nil
    
}
