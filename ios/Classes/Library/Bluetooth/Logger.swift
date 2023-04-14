//
//  Logger.swift
//  ble_lib
//
//  Created by Doan Ho on 14/04/2023.
//

import Foundation
import os

@available(iOS 14.0, *)
extension Logger {
   
    static let iOSCommonLibrarySubsystem = "com.hodoan.BLE-Libraries"
    
    // MARK: - Init
    
    init(_ clazz: AnyClass) {
        self.init(category: String(describing: clazz))
    }
    
    init(category: String) {
        self.init(subsystem: Logger.iOSCommonLibrarySubsystem, category: category)
    }
}
