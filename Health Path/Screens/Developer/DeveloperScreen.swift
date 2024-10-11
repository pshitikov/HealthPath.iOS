
import SwiftUI
import SFSafeSymbols

struct DeveloperScreen: View {
    
    // MARK: - Enums
    
    private enum Values {
        
        static let screenTitle = LocalizedStringKey("developer_screen_title")
        
        static let closeButtonTitle = LocalizedStringKey("reusable_close_title")
        
        static let serversSectionTitle = LocalizedStringKey("developer_screen_servers_section_title")
        static let serversSectionDescription = LocalizedStringKey("developer_screen_servers_section_description")
    }
    
    // MARK: - Properties
    
    @Environment(\.dismiss)
    private var dismiss
    
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
                case .servers(let servers): listView(servers)
                }
            }
            .onAppear { screenModel.send(event: .onAppearScreen) }
            .toolbar { toolbar }
            .navigationTitle(Values.screenTitle)
            .toolbarTitleDisplayMode(.inline)
        }
    }
}

// MARK: - Views

extension DeveloperScreen {
    
    @ToolbarContentBuilder
    private var toolbar: some ToolbarContent {
        ToolbarItem(placement: .topBarLeading) {
            Button(
                Values.closeButtonTitle,
                action: { dismiss() }
            )
        }
    }
    
    private func listView(_ servers: [Server]) -> some View {
        List {
            Section(
                content: { ForEach(servers) { server in rowView(server) } },
                header: { Text(Values.serversSectionTitle) },
                footer: { Text(Values.serversSectionDescription) }
            )
            .contentMargins(.top, CoreConstants.listTopPadding)
        }
    }
    
    private func rowView(_ server: Server) -> some View {
        Button(
            action: { screenModel.send(event: .didSelectServer(server)) },
            label: { buttonLabelView(server) }
        )
    }
    
    private func buttonLabelView(_ server: Server) -> some View {
        LabeledContent(
            content: { checkmarkView(server) },
            label: { labelView(server) }
        )
    }
    
    @ViewBuilder
    private func checkmarkView(_ server: Server) -> some View {
        if Server.currentServer == server {
            Image(systemName: SFSymbol.checkmark.rawValue)
                .foregroundStyle(Color.accentColor)
        }
    }
    
    private func labelView(_ server: Server) -> some View {
        Text(server.title)
            .foregroundStyle(Color.label)
    }
}

// MARK: - Previews

#Preview { DeveloperScreen(screenModel: .init()) }
