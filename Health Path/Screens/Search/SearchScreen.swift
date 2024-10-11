
import SwiftUI

struct SearchScreen: View {
    
    // MARK: - Enums
    
    private enum Values {
        
        static let screenTitle = "Поиск"
    }
    
    // MARK: - Properties
    
    @State
    private var screenModel: ScreenModel
    
    // MARK: - Initialization
    
    init(screenModel: ScreenModel) { _screenModel = State(initialValue: screenModel) }
    
    // MARK: - Body
    
    var body: some View {
        NavigationStack {
            Group {
                switch screenModel.state {
                case .initial: CoreEmptyListView()
                case .loading: CoreProgressView()
                case .data: listView
                case .error(let error): CoreErrorView(error: error)
                }
            }
            .onAppear { screenModel.send(event: .onAppearScreen) }
            .navigationTitle(Values.screenTitle)
            .toolbarTitleDisplayMode(UIDevice.current.userInterfaceIdiom == .phone ? .inlineLarge : .large)
        }
    }
}

// MARK: - Views

extension SearchScreen {
    
    private var listView: some View {
        List {
            Text("Item 1")
            Text("Item 2")
            Text("Item 3")
        }
    }
}

// MARK: - Screens

extension SearchScreen {
    
}

// MARK: - Previews

#Preview { SearchScreen(screenModel: .init()) }
