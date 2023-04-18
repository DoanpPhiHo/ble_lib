//
//  ScanningHandle.swift
//  ble_lib
//
//  Created by Doan Ho on 17/04/2023.
//

import Foundation
import Flutter

class ScanningHandle: NSObject, FlutterStreamHandler{
    private var sink: FlutterEventSink? = nil
    func onListen(withArguments arguments: Any?, eventSink events: @escaping FlutterEventSink) -> FlutterError? {
        sink = events
        return nil
    }
    
    func onCancel(withArguments arguments: Any?) -> FlutterError? {
        sink = nil
        return nil
    }
    
    func sendData(_ data: Bool) {
        sink?(data)
    }
}
