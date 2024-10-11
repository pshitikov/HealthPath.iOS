
import SwiftUI

extension PresentationInfoScreen {

    static func authorizationForFavoritesNeededScreen(didSelect: (() -> Void)?) -> PresentationInfoScreen {
        let model = Model(
            title: LocalizedStringKey("reusable_authorization_title"),
            description: LocalizedStringKey("presentation_info_screen_authorization_description"),
            buttonTitle: LocalizedStringKey("reusable_enter_phone_number_title"),
            didSelect: didSelect
        )
        
        return PresentationInfoScreen(model: model)
    }
    
    static func authorizationForCartNeededScreen(didSelect: (() -> Void)?) -> PresentationInfoScreen {
        let model = Model(
            title: LocalizedStringKey("reusable_authorization_title"),
            description: LocalizedStringKey("presentation_info_screen_authorization_cart_description"),
            buttonTitle: LocalizedStringKey("reusable_enter_phone_number_title"),
            didSelect: didSelect
        )
        
        return PresentationInfoScreen(model: model)
    }
}
