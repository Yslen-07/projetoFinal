import SwiftUI
import SwiftData

@main
struct ProjetoFinalApp: App {
    var body: some Scene {
        WindowGroup {
            MainTabView()
        }
        .modelContainer(for: [Jogo.self, Peca.self])
    }
}
