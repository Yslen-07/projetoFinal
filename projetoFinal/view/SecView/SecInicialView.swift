import SwiftUI
import SwiftData

struct SecInicialView: View {
    @Query var jogos: [Jogo]
    @Query var jogosNatacao: [JogoNatacao]
    
    var body: some View {
        NavigationStack {
            if jogos.isEmpty && jogosNatacao.isEmpty {
                Text("Nenhum jogo adicionado ainda.")
                    .foregroundColor(.gray)
                    .padding()
            } else {
                List {
                    if !jogos.isEmpty {
                        Section() {
                            ForEach(jogos) { jogo in
                                UniversalCardView(item: jogo)
                                    .swipeActions(edge: .trailing) {
                                    }
                            }
                        }
                    }
                    
                    // Seção para Natação
                    if !jogosNatacao.isEmpty {
                        Section() {
                            ForEach(jogosNatacao) { jogoNatacao in
                                UniversalCardView(item: jogoNatacao)
                                    .swipeActions(edge: .trailing) {
                                    }
                            }
                        }
                    }
                }
                .listStyle(.grouped)
            }
        }
        .navigationTitle("Jogos")
    }
}

#Preview {
    SecInicialView()
        .modelContainer(for: [Jogo.self, JogoNatacao.self], inMemory: true)
}
