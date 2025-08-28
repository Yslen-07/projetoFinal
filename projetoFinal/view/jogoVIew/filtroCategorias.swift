import SwiftUI
import SwiftData

struct FiltroCategoria: View {
    let categoriaSelecionada: String
    @Query var jogos: [Jogo]
    
    // Filtra todos os jogos da categoria selecionada
    var jogosFiltrados: [Jogo] {
        jogos.filter { $0.categoria.rawValue == categoriaSelecionada }
    }

    var body: some View {
        ScrollView {
            LazyVStack(spacing: 16) {
                if jogosFiltrados.isEmpty {
                    Text("Nenhum jogo de \(categoriaSelecionada).")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                        .frame(maxWidth: .infinity, alignment: .center)
                        .padding(.vertical, 8)
                } else {
                    ForEach(jogosFiltrados) { jogo in
                        JogoCardView(jogo: jogo)
                    }
                }
            }
            .padding()
        }
        .navigationTitle("Jogos de \(categoriaSelecionada)")
    }
}

#Preview {
    FiltroCategoria(categoriaSelecionada: "Basquete")
        .modelContainer(for: [Jogo.self, Peca.self])
}
