import SwiftUI
import SwiftData

struct CoverFlowCarouselWithFlipView: View {
    @Query(sort: \Peca.data) var pecas: [Peca]
    @State private var anoSelecionado: Int?

    var body: some View {
        NavigationStack {
            VStack {
                // Barra superior com filtro à esquerda e ranking à direita
                HStack {
                    Menu {
                        Button("Todos os anos") { anoSelecionado = nil }
                        ForEach(anosDisponiveis, id: \.self) { ano in
                            Button("\(ano)") { anoSelecionado = ano }
                        }
                    } label: {
                        Label("Filtrar por ano", systemImage: "calendar")
                            .foregroundColor(.blue)
                            .padding(8)
                            .background(Color.blue.opacity(0.1))
                            .clipShape(RoundedRectangle(cornerRadius: 8))
                    }
                    
                    Spacer()
                    
                    NavigationLink(destination: RankingPecasView()) {
                        VStack(spacing: 4) {
                            Image("rank")
                                .resizable()
                                .frame(width: 30, height: 30)
                            Text("Ranking")
                                .font(.caption2)
                                .foregroundColor(.gray)
                        }
                    }
                    .padding(8)
                    .clipShape(RoundedRectangle(cornerRadius: 8))
                }
                .padding(.horizontal)
                .padding(.top)

                // Carrossel
                if pecas.isEmpty {
                    Text("Nenhuma peça encontrada.")
                        .padding()
                } else {
                    GeometryReader { geo in
                        let cardWidth: CGFloat = 250
                        let sidePadding = (geo.size.width - cardWidth) / 2
                        
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack(spacing: 0) {
                                ForEach(pecasFiltradas) { peca in
                                    carouselCard(for: peca, in: geo.size)
                                }
                            }
                            .padding(.horizontal, sidePadding)
                            .padding(.vertical)
                        }
                    }
                    .frame(height: 550) // limita altura para o GeometryReader
                }
            }
            .navigationTitle("Peças")
        }
    }

    var pecasFiltradas: [Peca] {
        guard let ano = anoSelecionado else { return pecas }
        let calendar = Calendar.current
        let start = calendar.date(from: DateComponents(year: ano, month: 1, day: 1))!
        let end = calendar.date(from: DateComponents(year: ano + 1, month: 1, day: 1))!
        return pecas.filter { $0.data >= start && $0.data < end }
    }

    var anosDisponiveis: [Int] {
        let anos = Set(pecas.map { Calendar.current.component(.year, from: $0.data) })
        return Array(anos).sorted()
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
