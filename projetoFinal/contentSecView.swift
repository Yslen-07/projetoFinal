import SwiftUI
import SwiftData

struct ContentSecView: View {
    
    @Environment(\.modelContext) private var modelContext
    @Query(sort: \Jogo.data) private var jogos: [Jogo]
    @Environment(\.dismiss) private var dismiss
    
    @State private var jogoSelecionado: Jogo? = nil
    @State private var mostrarEdicao = false
    @State private var mostrarConfirmacaoDeletar = false
    @State private var criandoJogo: Bool = false
    
    var body: some View {
        NavigationStack {
            VStack {
                ScrollView {
                    //espaço entre os cards
                    LazyVStack(spacing: 10) {
                        ForEach(jogos) { jogo in
                            JogoCardView(jogo: jogo)
                                .onTapGesture {
                                    withAnimation {
                                        jogoSelecionado = jogo
                                    }
                                }
                        }
                    }
                    .padding()
                }
                
                if let jogo = jogoSelecionado {
                    Divider()
                        .padding(.vertical, 8)
                    
                    VStack(spacing: 12) {
                        JogoCardView(jogo: jogo)
                            .opacity(0.5)
                            .padding(.horizontal)

                        HStack(spacing: 30) {
                            Button("Editar") {
                                mostrarEdicao = true
                            }
                            .buttonStyle(.borderedProminent)

                            Button("Excluir") {
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
            .navigationTitle("Admin - Jogos")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        jogoSelecionado = nil
                        criandoJogo = true
                    } label: {
                        Image(systemName: "plus")
                    }
                }
            }
            // Sheet para criar novo jogo
            .sheet(isPresented: $criandoJogo) {
                SecFormView()
                    .environment(\.modelContext, modelContext)
            }
            // Sheet para edição
            .sheet(isPresented: $mostrarEdicao) {
                JogoEditingView()
                    .environment(\.modelContext, modelContext)
            }
            // Alerta de excluir jogo
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

#Preview {
    ContentSecView()
        .modelContainer(for: Jogo.self, inMemory: true)
}
