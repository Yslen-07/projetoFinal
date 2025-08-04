import SwiftUI
import SwiftData

struct JogosFiltradosPorCategoriaView: View {
    let categoriaSelecionada: String
    @Query private var todosOsJogos: [Jogo]

    var jogosFiltrados: [Jogo] {
        todosOsJogos.filter { $0.categoria.rawValue == categoriaSelecionada }
    }

    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                ForEach(jogosFiltrados) { jogo in
                    JogoCardView(jogo: jogo)
                }
            }
            .padding()
        }
        .navigationTitle(categoriaSelecionada)
    }
}
