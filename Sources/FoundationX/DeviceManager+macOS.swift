//
//  DeviceManager+macOS.swift
//  FoundationX
// 
//  Created by 梁光辉 on 2024/6/16.
//  Copyright © 2024 Guanghui Liang. All rights reserved.
//

import Foundation
import SystemConfiguration

#if os(macOS)
extension DeviceManager {
    class func collectMACAddresses() -> [String] {
        guard let interfaces = SCNetworkInterfaceCopyAll() as? [SCNetworkInterface] else {
            return []
        }
        
        return interfaces
            .map(SCNetworkInterfaceGetHardwareAddressString)
            .compactMap { $0 as String? }
    }
    
    class func getSerialNumber() -> String? {
        let platformExpert = IOServiceGetMatchingService(kIOMasterPortDefault, IOServiceMatching("IOPlatformExpertDevice"))
        if platformExpert != 0 {
            let serialNumberAsCFString = IORegistryEntryCreateCFProperty(platformExpert, kIOPlatformSerialNumberKey as CFString, kCFAllocatorDefault, 0).takeUnretainedValue() as? String
            IOObjectRelease(platformExpert)
            return serialNumberAsCFString
        }
        return nil
    }
}
#endif
