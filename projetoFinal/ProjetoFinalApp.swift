import SwiftUI
import SwiftData

@main
struct ProjetoFinalApp: App {
    var body: some Scene {
        WindowGroup {
            SecView()
        }
        .modelContainer(for: Jogo.self)
    }
}
