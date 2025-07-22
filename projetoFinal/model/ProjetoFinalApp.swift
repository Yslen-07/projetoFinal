import SwiftUI
import SwiftData

@main
struct ProjetoFinalApp: App {
    var body: some Scene {
        WindowGroup {
            CoverFlowCarouselWithFlipView()
        }
        .modelContainer(for: [Jogo.self, Peca.self])
    }
}
