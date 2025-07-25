import SwiftUI
import SwiftData

struct SecAlunoView: View {
    @Query var jogos: [Jogo]
    @State private var jogoParaEditar: Jogo?

    var body: some View {
        NavigationStack {
            if jogos.isEmpty {
                Text("Nenhum jogo adicionado ainda.")
                    .foregroundColor(.gray)
                    .padding()
            } else {
                List {
                    ForEach(jogos) { jogo in
                        JogoCardView(jogo: jogo)
                            .swipeActions(edge: .trailing) {
                                Button("Editar") {
                                    jogoParaEditar = jogo
                                }
                                .tint(.blue)
                            }
                    }
                }
                .sheet(item: $jogoParaEditar) { jogo in
                    JogoEditingView(jogo: jogo)
                }
            }
        }
    }
}
#Preview {
    SecAlunoView()
        .modelContainer(for: Jogo.self, inMemory: true)
}
