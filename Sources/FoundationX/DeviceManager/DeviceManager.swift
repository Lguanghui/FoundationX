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

@MainActor
public final class DeviceManager {
    public static let shared: DeviceManager = DeviceManager()
    
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
        appName = infoDict?["CFBundleDisplayName"] as? String ?? (infoDict?["CFBundleName"] as? String ?? "")
    }
    
    #if os(macOS)
    /// device's mac addresses.
    public let macAddresses: [String]
    /// device's serial number.
    public let serialNumber: String
    #endif
    /// device's current system version. e.g. 17.5.1
    public let systemVersion: String
    
    /// application's current version.
    public let appVsersion: String
    /// application's current build number..
    public let buildNumber: String
    
    /// the name of current application.
    public let appName: String
}
