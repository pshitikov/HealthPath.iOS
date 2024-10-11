
import Foundation
import SwiftUI

struct AppError: CoreErrorViewProtocol, Equatable {
    
    // MARK: - Properties
    
    var title: String?
    var description: String?
    var imageLink: String?
    var imageResource: ImageResource?
    var withRetryButton: Bool
    var code: Int?
    
    // MARK: - Initialization
    
    init(
        title: String? = nil,
        description: String? = nil,
        imageLink: String? = nil,
        imageResource: ImageResource? = nil,
        withRetryButton: Bool = true,
        code: Int? = nil
    ) {
        self.title = title
        self.description = description
        self.imageLink = imageLink
        self.imageResource = imageResource
        self.withRetryButton = withRetryButton
        self.code = code
    }
    
    init(error: Error) {
        switch error {
        case let error as ServerError:
            title = error.title
            description = error.description
            imageLink = error.imageLink
            withRetryButton = false
            code = error.code
        case let error as AppError:
            title = error.title
            description = error.description
            imageLink = error.imageLink
            imageResource = error.imageResource
            withRetryButton = error.withRetryButton
        default:
            title = AppError.unknown.title
            description = AppError.unknown.description
            withRetryButton = true
        }
    }
}

// MARK: - App errors

extension AppError {
    
    static let unknown = Self(
        title: "Не удалось подключиться",
        description: "Простите, не могли бы Вы повторить?"
    )
    
    static func verifyLater(title: String, description: String) -> Self { Self(title: title, description: description) }
    
    static let versionIsNotAvailable = Self(
        title: "Ваше приложение устарело",
        description: "Установите новое приложение Shi.Bakery по ссылке ниже."
    )
    
    static let userIsNotAuthorized = Self(
        title: "Пользователь не авторизован",
        description: "Пожалуйста, авторизуйтесь, чтобы продолжить"
    )
}
