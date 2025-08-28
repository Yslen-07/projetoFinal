import SwiftUI
import SwiftData

struct ContentSecView: View {
    @Environment(\.modelContext) private var modelContext
    @Query(sort: \Jogo.data) private var jogos: [Jogo]
    @Query(sort: \JogoNatacao.data) private var jogosNatacao: [JogoNatacao]
    @Environment(\.dismiss) private var dismiss
    
    @State private var itemSelecionado: Any? = nil
    @State private var mostrarEdicao = false
    @State private var mostrarConfirmacaoDeletar = false
    @State private var criandoJogo: Bool = false
    
    var body: some View {
        NavigationStack {
            VStack {
                ScrollView {
                    LazyVStack(spacing: 10) {
                       
                        if !jogos.isEmpty {
                            Section {
                                ForEach(jogos) { jogo in
                                    UniversalCardView(item: jogo)
                                        .onTapGesture {
                                            withAnimation {
                                                itemSelecionado = jogo
                                            }
                                        }
                                }
                            }
                        }
                        
                    
                        if !jogosNatacao.isEmpty {
                            Section {
                                ForEach(jogosNatacao) { jogoNatacao in
                                    UniversalCardView(item: jogoNatacao)
                                        .onTapGesture {
                                            withAnimation {
                                                itemSelecionado = jogoNatacao
                                            }
                                        }
                                }
                            }
                        }
                    }
                    .padding()
                }
                
                if itemSelecionado != nil {
                    Divider()
                        .padding(.vertical, 8)
                    
                    VStack(spacing: 12) {
                        UniversalCardView(item: itemSelecionado!) 
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
                        itemSelecionado = nil
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
                if let jogo = itemSelecionado as? Jogo {
                    JogoEditingView(jogo: jogo)
                        .environment(\.modelContext, modelContext)
                } else if let natacao = itemSelecionado as? JogoNatacao {
                    JogoEditingView(jogoNatacao: natacao)
                        .environment(\.modelContext, modelContext)
                }
            }
            // Alerta de excluir jogo
            .alert("Deseja excluir este jogo?", isPresented: $mostrarConfirmacaoDeletar) {
                Button("Excluir", role: .destructive) {
                    if let jogo = itemSelecionado as? Jogo {
                        modelContext.delete(jogo)
                        itemSelecionado = nil
                    } else if let natacao = itemSelecionado as? JogoNatacao {
                        modelContext.delete(natacao)
                        itemSelecionado = nil
                    }
                }
                Button("Cancelar", role: .cancel) { }
            }
        }
    }
}

#Preview {
    ContentSecView()
        .modelContainer(for: [Jogo.self, JogoNatacao.self], inMemory: true)
}
