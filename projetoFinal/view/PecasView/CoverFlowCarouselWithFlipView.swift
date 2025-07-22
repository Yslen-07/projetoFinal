import SwiftUI
import SwiftData

struct CoverFlowCarouselWithFlipView: View {
    @Query(sort: \Peca.data) var pecas: [Peca]

    var body: some View {
        NavigationStack {
            if pecas.isEmpty {
                Text("Nenhuma peça encontrada.")
                    .padding()
            } else {
                GeometryReader { geo in
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 0) {
                            ForEach(pecas) { peca in
                                carouselCard(for: peca, in: geo.size)
                            }
                        }
                        .padding(.horizontal, 24)
                        .padding(.vertical)
                    }
                }
                .navigationTitle("Cartaz")
            }
        }
    }

    @ViewBuilder
    func carouselCard(for peca: Peca, in containerSize: CGSize) -> some View {
        GeometryReader { cardGeo in
            let midX = cardGeo.frame(in: .global).midX
            let center = containerSize.width / 2
            let distance = abs(center - midX)

            let angle = (center - midX) / 20
            let scale = max(0.85, 1.1 - distance / 400)

            PecaCardFlipView(peca: peca)
                .scaleEffect(scale)
                .rotation3DEffect(.degrees(angle), axis: (x: 0, y: 1, z: 0))
                .animation(.easeInOut(duration: 0.3), value: angle)
                .padding(.horizontal, 12)
        }
        .frame(width: 250, height: 380)
    }
}
#Preview {
    CoverFlowCarouselWithFlipView()
        .modelContainer(for: Peca.self, inMemory: true)
}
