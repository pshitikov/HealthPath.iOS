
import SwiftUI

struct MenuScreen: View {
    
    // MARK: - Properties
    
    @State
    private var screenModel: MenuScreen.ScreenModel
    
    // MARK: - Initialization
    
    init(screenModel: MenuScreen.ScreenModel) { _screenModel = State(initialValue: screenModel) }
    
    // MARK: - Body
    
    var body: some View {
        Group {
            switch screenModel.state {
            case .initial: CoreEmptyListView()
            case .loading: CoreProgressView()
            case .menu(let menu): tabBarView(menu: menu)
            case .error(let error): errorView(error)
            }
        }
        .onAppear { screenModel.send(event: .onAppearScreen) }
    }
}

// MARK: - Views

extension MenuScreen {
    
    private func errorView(_ error: AppError) -> some View {
        CoreErrorView(error: error)
            .withOpacityAnimation()
    }
    
    private func tabBarView(menu: [MenuService.Menu]) -> some View {
        TabView(selection: $screenModel.tabBarSelection) {
            ForEach(menu) { menu in
                buildScreen(menu: menu)
                    .tabItem {
                        VStack { menuItemView(menu) }
                            .tint(.accentColor)
                    }
            }
        }
        .withOpacityAnimation()
    }
    
    @ViewBuilder
    private func menuItemView(_ menu: MenuService.Menu) -> some View {
        Group {
            menu.image
                .renderingMode(.template)
            
            Text(menu.name)
        }
    }
}

// MARK: - Screens

extension MenuScreen {
    
    private func buildScreen(menu: MenuService.Menu) -> some View {
        Group {
            switch menu {
            case .feed: feedScreen
            case .diary: diaryScreen
            case .search: searchScreen
            }
        }
    }
    
    private var feedScreen: some View {
        NavigationStack(path: $screenModel.feedPath) {
            FeedScreen(screenModel: .init())
        }
    }
    
    private var diaryScreen: some View {
        NavigationStack(path: $screenModel.diaryPath) {
            DiaryScreen(screenModel: .init())
        }
    }
    
    private var searchScreen: some View {
        NavigationStack(path: $screenModel.searchPath) {
            SearchScreen(screenModel: .init())
        }
    }
}

// MARK: - Screens

extension MenuScreen {
    
}

// MARK: - Previews

#Preview { MenuScreen(screenModel: .init()) }
