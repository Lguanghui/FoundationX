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
        let platformExpert = IOServiceGetMatchingService(kIOMainPortDefault, IOServiceMatching("IOPlatformExpertDevice"))
        if platformExpert != 0 {
            let serialNumberProperty = IORegistryEntryCreateCFProperty(platformExpert, kIOPlatformSerialNumberKey as CFString, kCFAllocatorDefault, 0)
            let serialNumber = serialNumberProperty?.takeRetainedValue() as? String
            IOObjectRelease(platformExpert)
            return serialNumber
        }
        return nil
    }
}
#endif
