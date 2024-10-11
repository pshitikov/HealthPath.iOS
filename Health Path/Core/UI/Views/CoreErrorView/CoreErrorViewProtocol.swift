
import SwiftUI

protocol CoreErrorViewProtocol: Error {
    
    var title: String? { get }
    var description: String? { get }
    var imageLink: String? { get }
    var imageResource: ImageResource? { get }
    var withRetryButton: Bool { get }
}
