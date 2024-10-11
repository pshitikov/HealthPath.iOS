
import UIKit
import Moya
import DeviceKit
import Alamofire

enum AuthorizationRequestProvider: TargetType {
    
    // MARK: - Cases
    
    case verifyPhoneNumber(phoneNumber: String)
    case signIn(verificationId: UUID, verificationOTP: String)
    case signOut(userId: String)
    case createPushToken(userId: String, pushToken: String)
    
    // MARK: - Properties
    
    var baseURL: URL { Server.currentServer.url }
    
    var path: String {
        switch self {
        case .verifyPhoneNumber: "/auth/verifyPhoneNumber"
        case .signIn: "/auth/signIn"
        case .signOut(let userId): "/users/\(userId)/signOut"
        case .createPushToken(let userId, _): "/users/\(userId)/pushTokens"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .verifyPhoneNumber, .signIn, .createPushToken: .post
        case .signOut: .get
        }
    }
    
    var task: Task {
        switch self {
        case .signOut: return .requestPlain
        case .createPushToken(_, let pushToken):
            let parameters: [String: Any] = [
                "pushToken": pushToken,
            ]
            
            return .requestParameters(parameters: parameters, encoding: JSONEncoding.default)
        case .verifyPhoneNumber(let phoneNumber):
            let parameters: [String: Any] = [
                "phoneNumber": phoneNumber,
            ]
            
            return .requestParameters(parameters: parameters, encoding: JSONEncoding.default)
        case .signIn(let verificationId, let verificationOTP):
            let parameters: [String: Any] = [
                "verificationId": verificationId.uuidString,
                "verificationOTP": verificationOTP,
            ]
            
            return .requestParameters(parameters: parameters, encoding: JSONEncoding.default)
        }
    }
    
    var headers: [String: String]? { DefaultHeaders.shared.headers }
}
