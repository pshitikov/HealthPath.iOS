
import DeviceKit
import UIKit

final class DefaultHeaders {
    
    static let shared = DefaultHeaders()
    
    var headers: [String: String]? {
        var headers: [String: String] = [
            "Content-Type": "application/json",
            "Terminal-Id": UIDevice.current.identifierForVendor?.uuidString ?? UUID().uuidString,
            "Terminal-Model": Device.current.description,
            "Application-Version": UIApplication.fullVersion,
        ]
        
        if let systemName = Device.current.systemName {
            headers["Terminal-Type"] = systemName
        }
        
        if let systemVersion = Device.current.systemVersion {
            headers["Terminal-OS-Version"] = systemVersion
        }
        
        if let token = ServiceLocator.authorizationService.token {
            headers["Authorization"] = "Bearer \(token)"
        }
        
        return headers
    }
}
