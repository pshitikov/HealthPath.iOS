
import SwiftUI

struct ServerError: Error, Codable {
    
    // MARK: - Properties
    
    let code: Int
    let title: String?
    let description: String?
    let imageLink: String?
}
