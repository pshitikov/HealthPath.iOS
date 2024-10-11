
import SwiftUI
import Moya
import SimpleKeychain

@Observable
final class AuthorizationService {
    
    // MARK: - Enums
    
    private enum Values {
        
        static let canResendAfter: TimeInterval = 120
        static let verificationCodeLenght: Int = 4
        
        static let tokenKeychainKey = "token"
        static let userIdKeychainKey = "userId"
    }
    
    // MARK: - Properties
    
    private let authProvider = MoyaProvider<AuthorizationRequestProvider>(
        plugins: [
            NetworkLoggerPlugin(configuration: .init(logOptions: .verbose)),
        ]
    )
    
    private let simpleKeychain = SimpleKeychain()
    
    private(set) var resendTime: TimeInterval = 0
    
    private var resendTimer: Timer?
    private var currentPhoneNumber: String?
    private var currentVerificationId: UUID?
    
    private(set) var token: String?
    private(set) var userId: String?
    
    private(set) var isUserAuthorized = false
    
    private(set) var isPhoneNumberScreenPresented = false
    
    // MARK: - Internal functions
    
    init() {
        token = try? simpleKeychain.string(forKey: Values.tokenKeychainKey)
        userId = try? simpleKeychain.string(forKey: Values.userIdKeychainKey)
        
        if token == nil {
            clearCache()
        } else {
            isUserAuthorized = true
        }
    }
    
    func createPushToken(userId: String, pushToken: String) async throws {
        try await authProvider.async.request(.createPushToken(userId: userId, pushToken: pushToken))
    }
    
    func verificationCodeLenght() -> Int { Values.verificationCodeLenght }
    
    func presentPhoneNumberScreen(result: Bool, delay: TimeInterval = 0) {
        DispatchQueue.main.asyncAfter(wallDeadline: .now() + delay) { [weak self] in
            guard let self else { return }
            
            isPhoneNumberScreenPresented = result
        }
    }
    
    func verifyPhoneNumber(_ phoneNumber: String) async throws -> UUID {
        guard resendTime.isZero else {
            if currentPhoneNumber == phoneNumber, let currentVerificationId {
                return currentVerificationId
            } else {
                throw AppError.verifyLater(
                    title: "Вы уже отправяли код",
                    description: "Повторите попытку через \(resendTime.format(using: .second) ?? "")"
                )
            }
        }
        
        do {
            let verifyPhoneNumberDTO: VerifyPhoneNumberDTO = try await authProvider.async.request(.verifyPhoneNumber(phoneNumber: phoneNumber))
            
            currentPhoneNumber = phoneNumber
            currentVerificationId = verifyPhoneNumberDTO.verificationId
            
            startResendTimer()
            
            return verifyPhoneNumberDTO.verificationId
        } catch {
            throw AppError(error: error)
        }
    }
    
    func signIn(verificationId: UUID, verificationCode: String, phoneNumber: String) async throws {
        do {
            let signInDTO: SignInDTO = try await authProvider.async.request(
                .signIn(
                    verificationId: verificationId,
                    verificationOTP: verificationCode
                )
            )
            
            try simpleKeychain.set(signInDTO.token.uuidString, forKey: Values.tokenKeychainKey)
            try simpleKeychain.set(signInDTO.userId.uuidString, forKey: Values.userIdKeychainKey)

            token = signInDTO.token.uuidString
            userId = signInDTO.userId.uuidString
            isUserAuthorized = true
            
            isPhoneNumberScreenPresented = false
        } catch {
            throw AppError(error: error)
        }
    }
    
    func signOut() async throws {
        guard let userId else { throw AppError.userIsNotAuthorized }
        
        do {
            try await authProvider.async.request(.signOut(userId: userId))
            clearCache()
        } catch {
            throw AppError(error: error)
        }
    }
    
    // MARK: - Private functions
    
    func clearCache() {
        isUserAuthorized = false
        token = nil
        userId = nil
        
        _Concurrency.Task { @MainActor in
            try simpleKeychain.deleteAll()
        }
    }
    
    private func startResendTimer() {
        let timer = Timer(
            timeInterval: 1,
            target: self,
            selector: #selector(timerCount),
            userInfo: nil,
            repeats: true
        )
        
        resendTimer = timer
        resendTime = Values.canResendAfter
        
        RunLoop.main.add(timer, forMode: .common)
    }
    
    @objc
    private func timerCount(_ timer: Timer) {
        if resendTime.isZero {
            resendTimer = nil
            currentVerificationId = nil
            
            timer.invalidate()
        } else {
            resendTime -= 1
        }
    }
}
