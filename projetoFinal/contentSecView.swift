import SwiftUI
import SwiftData

struct ContentSecView: View {
    @Environment(\.modelContext) private var modelContext
    @Query(sort: \Jogo.data) private var jogos: [Jogo]

    @State private var jogoSelecionado: Jogo? = nil
    @State private var mostrarEdicao = false
    @State private var mostrarConfirmacaoDeletar = false

    var body: some View {
        NavigationStack {
            VStack {
                List(jogos, id: \.id) { jogo in
                    JogoCardView(jogo: jogo)
                        .onTapGesture {
                            withAnimation {
                                jogoSelecionado = jogo
                            }
                        }
                }
                .listStyle(.insetGrouped)
                .navigationTitle("Admin - Jogos")
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button {
                            jogoSelecionado = nil
                            mostrarEdicao = true // abrir form pra novo jogo
                        } label: {
                            Image(systemName: "plus")
                        }
                    }
                }
                
                // Área de edição/exclusão abaixo, aparece só se jogoSelecionado não for nil
                if let jogo = jogoSelecionado {
                    Divider()
                        .padding(.vertical, 8)

                    VStack(spacing: 12) {
                        JogoCardView(jogo: jogo)
                            .opacity(0.5) // aparência opaca
                            .padding(.horizontal)

                        HStack(spacing: 30) {
                            Button("Editar") {
                                mostrarEdicao = true
                            }
                            .buttonStyle(.borderedProminent)

                            Button("Deletar") {
                                mostrarConfirmacaoDeletar = true
                            }
                            .buttonStyle(.bordered)
                            .tint(.red)
                        }
                    }
                    .padding()
                    .background(.regularMaterial)
                    .cornerRadius(20)
                    .padding(.horizontal)
                }
            }
            // Sheet para edição/novo jogo
            .sheet(isPresented: $mostrarEdicao) {
                JogoEditingView(jogo: jogoSelecionado)
//                    .environment(\.modelContext, modelContext)
            }
            // Alert para deletar
            .alert("Deseja excluir este jogo?", isPresented: $mostrarConfirmacaoDeletar) {
                Button("Excluir", role: .destructive) {
                    if let jogo = jogoSelecionado {
                        modelContext.delete(jogo)
                        jogoSelecionado = nil
                    }
                }
                Button("Cancelar", role: .cancel) { }
            }
        }
    }
}
