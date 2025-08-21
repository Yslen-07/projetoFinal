import SwiftUI
import SwiftData

struct SecAdmView: View {
    @Query var jogos: [Jogo]
    @State private var jogoParaEditar: Jogo?
//    @Environment(\.dismiss) private var dismiss
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
    SecAdmView()
        .modelContainer(for: Jogo.self, inMemory: true)
}
