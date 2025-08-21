import SwiftUI
import SwiftData

struct FiltroCategoria: View {
    let categoriaSelecionada: String
    @Query var jogos: [Jogo]
    
    var jogosFiltrados: [Jogo] {
        let hoje = Calendar.current.startOfDay(for: Date())
        return jogos.filter {
            Calendar.current.isDate($0.data, inSameDayAs: hoje) &&
            $0.categoria.rawValue == categoriaSelecionada
        }
    }

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 24) {

                if jogosFiltrados.isEmpty {
                    // fallback centralizado
                    Text("Nenhum jogo de \(categoriaSelecionada).")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                        .frame(maxWidth: .infinity, alignment: .center)
                        .padding(.vertical, 8)
                    
                } else {
                    // lista de jogos em carrossel lateral
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 16) {
                            ForEach(jogosFiltrados) { jogo in
                                JogoCardView(jogo: jogo)
                            }
                        }
                        .padding(.horizontal)
                    }
                }
            }
            .padding(.vertical)
        }
        .navigationTitle(Text("Jogos de \(categoriaSelecionada)"))
    }
}

#Preview {
    FiltroCategoria(categoriaSelecionada: "Basquete")
        .modelContainer(for: [Jogo.self, Peca.self])
}
