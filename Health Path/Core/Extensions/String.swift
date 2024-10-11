
import Foundation

extension String {
    
    func smartContains(_ other: String) -> Bool {
        let array: [String] = other
            .lowercased()
            .components(separatedBy: " ")
            .filter { !$0.isEmpty }
    
        let result = array
            .allSatisfy { lowercased().range(of: $0) != nil }
        
        return result
    }
}
