
import Moya
import UIKit
import DeviceKit

extension MoyaProvider {
    
    final class MoyaConcurrency {
        
        // MARK: - Properties
        
        private let provider: MoyaProvider
        
        // MARK: - Initialization
        
        init(provider: MoyaProvider) { self.provider = provider }
        
        // MARK: - Internal functions
        
        func request(_ target: Target) async throws {
            try await withCheckedThrowingContinuation { (continuation: CheckedContinuation<Void, Error>) in
                provider.request(target) { result in
                    switch result {
                    case .success(let response):
                        switch response.statusCode {
                        case 200..<300:
                            continuation.resume()
                        default:
                            do {
                                let errorData = try JSONDecoder.default.decode(ServerErrorData.self, from: response.data)
                                
                                continuation.resume(throwing: errorData.error)
                            } catch {
                                continuation.resume(throwing: error)
                            }
                        }
                    case .failure(let error):
                        continuation.resume(throwing: error)
                    }
                }
            }
        }
        
        func request<T: Decodable>(_ target: Target) async throws -> T {
            try await withCheckedThrowingContinuation { continuation in
                provider.request(target) { result in
                    switch result {
                    case .success(let response):
                        switch response.statusCode {
                        case 200..<300:
                            do {
                                let object = try JSONDecoder.default.decode(T.self, from: response.data)
                                
                                continuation.resume(returning: object)
                            } catch {
                                continuation.resume(throwing: error)
                            }
                        default:
                            do {
                                let errorData = try JSONDecoder.default.decode(ServerErrorData.self, from: response.data)
                                
                                continuation.resume(throwing: errorData.error)
                            } catch {
                                continuation.resume(throwing: error)
                            }
                        }
                    case .failure(let error):
                        continuation.resume(throwing: error)
                    }
                }
            }
        }
    }
}

// MARK: - Extensions

extension MoyaProvider {
    
    // MARK: - Properties
    
    var async: MoyaConcurrency { MoyaConcurrency(provider: self) }
}

extension JSONDecoder {
    
    static var `default`: JSONDecoder {
        let decoder = JSONDecoder()
        
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        decoder.dateDecodingStrategy = .iso8601
        
        return decoder
    }
}
