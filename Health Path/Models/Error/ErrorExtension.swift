
import SwiftUI

extension Error {
    
    // MARK: - Properties
    
    var title: String? {
        switch self {
        case let error as ServerError: error.title
        case let error as AppError: error.title
        default: ""
        }
    }
    
    var description: String? {
        switch self {
        case let error as ServerError: error.description
        case let error as AppError: error.description
        default: nil
        }
    }
    
    var imageLink: String? {
        switch self {
        case let error as ServerError: error.imageLink
        case let error as AppError: error.imageLink
        default: nil
        }
    }
    
    var imageResource: ImageResource? {
        switch self {
        case let error as ServerError: error.imageResource
        case let error as AppError: error.imageResource
        default: nil
        }
    }
}
