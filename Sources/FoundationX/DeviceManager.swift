//
//  DeviceManager.swift
//  FoundationX 
// 
//  Created by 梁光辉 on 2024/6/16.
//  Copyright © 2024 Guanghui Liang. All rights reserved.
//

import Foundation

#if canImport(UIKit)
import UIKit
#endif

public final class DeviceManager {
    static let shared: DeviceManager = DeviceManager()
    
    init() {
#if os(macOS)
        macAddresses = Self.collectMACAddresses()
        serialNumber = Self.getSerialNumber() ?? ""
        let osVersion = ProcessInfo.processInfo.operatingSystemVersion
        systemVersion = "\(osVersion.majorVersion).\(osVersion.minorVersion).\(osVersion.patchVersion)"
#else
        systemVersion = UIDevice.current.systemVersion
#endif
        
        let infoDict = Bundle.main.infoDictionary
        appVsersion = infoDict?["CFBundleShortVersionString"] as? String ?? ""
        buildNumber = infoDict?["CFBundleVersion"] as? String ?? ""
    }
    
    #if os(macOS)
    public let macAddresses: [String]
    public let serialNumber: String
    #endif
    public let systemVersion: String
    
    let appVsersion: String
    let buildNumber: String
}
