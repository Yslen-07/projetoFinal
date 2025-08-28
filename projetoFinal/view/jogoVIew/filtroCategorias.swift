import SwiftUI
import SwiftData

struct FiltroCategoria: View {
    let categoriaSelecionada: String
    
    @Query(sort: \Jogo.data) private var jogos: [Jogo]
    @Query(sort: \JogoNatacao.data) private var jogosNatacao: [JogoNatacao]
    
    // Filtra cada tipo de jogo
    private var jogosFiltrados: [Jogo] {
        jogos.filter { $0.categoria.rawValue == categoriaSelecionada }
    }
    
    private var natacaoFiltrados: [JogoNatacao] {
        jogosNatacao.filter { $0.categoria.rawValue == categoriaSelecionada }
    }
    
    var body: some View {
        ScrollView {
            LazyVStack(spacing: 16) {
                // Todos os jogos normais
                ForEach(jogosFiltrados) { jogo in
                    UniversalCardView(item: jogo)
                }
                
                // Todos os jogos de natação
                ForEach(natacaoFiltrados) { natacao in
                    UniversalCardView(item: natacao)
                }
                
                // Caso não haja nenhum jogo na categoria
                if jogosFiltrados.isEmpty && natacaoFiltrados.isEmpty {
                    Text("Nenhum jogo de \(categoriaSelecionada).")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                        .frame(maxWidth: .infinity, alignment: .center)
                        .padding(.vertical, 8)
                }
            }
            .padding()
        }
        .navigationTitle("Jogos de \(categoriaSelecionada)")
    }
}

// Preview
#Preview {
    FiltroCategoria(categoriaSelecionada: "Basquete")
        .modelContainer(for: [Jogo.self, Peca.self, JogoNatacao.self])
}
