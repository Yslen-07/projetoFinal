import SwiftUI
import SwiftData

struct SecAdmView: View {
    @Query var jogos: [Jogo]
    @Query var jogosNatacao: [JogoNatacao]
    
    @State private var itemParaEditar: Any?
    @State private var showingEditSheet = false
    
    var body: some View {
        NavigationStack {
            if jogos.isEmpty && jogosNatacao.isEmpty {
                Text("Nenhum jogo adicionado ainda.")
                    .foregroundColor(.gray)
                    .padding()
            } else {
                List {
                    // Seção para Jogos Normais
                    if !jogos.isEmpty {
                        Section("Jogos de Equipe") {
                            ForEach(jogos) { jogo in
                                UniversalCardView(item: jogo)
                                    .swipeActions(edge: .trailing) {
                                        Button("Editar") {
                                            itemParaEditar = jogo
                                            showingEditSheet = true
                                        }
                                        .tint(.blue)
                                    }
                            }
                        }
                    }
                    
                    // Seção para Natação
                    if !jogosNatacao.isEmpty {
                        Section("Natação") {
                            ForEach(jogosNatacao) { jogoNatacao in
                                UniversalCardView(item: jogoNatacao)
                                    .swipeActions(edge: .trailing) {
                                        Button("Editar") {
                                            itemParaEditar = jogoNatacao
                                            showingEditSheet = true
                                        }
                                        .tint(.blue)
                                    }
                            }
                        }
                    }
                }
                .sheet(isPresented: $showingEditSheet) {
                    if let item = itemParaEditar {
                        if let jogo = item as? Jogo {
                            JogoEditingView(jogo: jogo)
                        } else if let jogoNatacao = item as? JogoNatacao {
                            JogoEditingView(jogo: jogoNatacao)
                        }
                    }
                }
            }
        }
        .navigationTitle("Gerenciar Jogos")
    }
}

#Preview {
    SecAdmView()
        .modelContainer(for: [Jogo.self, JogoNatacao.self], inMemory: true)
}
