import SwiftUI
import SwiftData

struct CarouselEventoshj: View {
    @Query var pecas: [Peca]

    var pecasHoje: [Peca] {
        let hoje = Calendar.current.startOfDay(for: Date())
        return pecas.filter { Calendar.current.isDate($0.data, inSameDayAs: hoje) }
    }

    var body: some View {
        NavigationStack {
            if pecasHoje.isEmpty {
                Text("Nenhuma peça para hoje.")
                    .padding()
            } else {
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 16) {
                        ForEach(pecasHoje) { peca in
                            GeometryReader { cardGeo in
                                let cardWidth: CGFloat = 250
                                let cardHeight: CGFloat = 350
                                let midX = cardGeo.frame(in: .global).midX
                                let screenCenter = UIScreen.main.bounds.width / 2
                                let distance = abs(screenCenter - midX)
                                let scale = max(0.90, 1.1 - distance / 400)

                                PecaCardFlipView(peca: peca, width: cardWidth, height: cardHeight)
                                    .scaleEffect(scale)
                                    .animation(.easeInOut(duration: 0.3), value: scale)
                            }
                            .frame(width: 250, height: 380)
                        }
                    }
                    .padding(.horizontal, 60)
                    .padding(.vertical, 20)
                }
                .navigationTitle("Peças de Hoje")
            }
        }
    }
}

#Preview {
    CarouselEventoshj()
        .modelContainer(for: Peca.self, inMemory: true)
}
