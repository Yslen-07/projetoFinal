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
                    let cardWidth: CGFloat = 250
                    let sidePadding = (geo.size.width - cardWidth) / 2
                    
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 0) {
                            ForEach(pecas) { peca in
                                carouselCard(for: peca, in: geo.size)
                            }
                        }
                        .padding(.horizontal, sidePadding)
                        .padding(.vertical)
                    }
                }
                .navigationTitle("Peças")
            }
        }
    }

    @ViewBuilder
    func carouselCard(for peca: Peca, in containerSize: CGSize) -> some View {
        GeometryReader { cardGeo in
            let midX = cardGeo.frame(in: .global).midX
            let center = containerSize.width / 2
            let distance = abs(center - midX)

            let scale = max(0.85, 1.1 - distance / 400)

            PecaCardFlipView(peca: peca)
                .scaleEffect(scale)
                .animation(.easeInOut(duration: 0.3), value: scale)
                .padding(.horizontal, 12)
        }
        .frame(width: 300, height: 500)
        .offset(x: 0 , y: 50)
    }
}

#Preview {
    CoverFlowCarouselWithFlipView()
        .modelContainer(for: Peca.self, inMemory: true)
}
