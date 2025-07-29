import SwiftUI
import SwiftData

@main
struct ProjetoFinalApp: App {
    var body: some Scene {
        WindowGroup {
            HomePage()
        }
        .modelContainer(for: [Jogo.self, Peca.self])
    }
}
