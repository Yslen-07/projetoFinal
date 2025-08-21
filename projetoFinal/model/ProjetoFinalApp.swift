import SwiftUI
import SwiftData

@main
struct ProjetoFinalApp: App {
    var body: some Scene {
        WindowGroup {
            OnBoardingView()
        }
        .modelContainer(for: [Jogo.self, Peca.self])
    }
}
