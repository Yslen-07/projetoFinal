import SwiftUI
import SwiftData

struct ContentSecView: View {
    @Environment(\.modelContext) private var modelContext
    @Query(sort: \Jogo.data) private var jogos: [Jogo]
    @Query(sort: \JogoNatacao.data) private var jogosNatacao: [JogoNatacao]
    @State private var mostrandoCriacao = false
    
    var body: some View {
        NavigationStack {
            ScrollView {
                LazyVStack(spacing: 12) {
                    // Jogos gerais
                    ForEach(jogos) { jogo in
                        NavigationLink(destination: JogoEditingView(jogo: jogo)
                            .environment(\.modelContext, modelContext)) {
                            UniversalCardView(item: jogo)
                        }
                        .buttonStyle(PlainButtonStyle())
                    }
                    
                    // Jogos de natação
                    ForEach(jogosNatacao) { natacao in
                        NavigationLink(destination: JogoEditingView(jogoNatacao: natacao)
                            .environment(\.modelContext, modelContext)) {
                            UniversalCardView(item: natacao)
                        }
                        .buttonStyle(PlainButtonStyle())
                    }
                }
                .padding()
            }
            .navigationTitle("Admin - Jogos")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        mostrandoCriacao = true
                    } label: {
                        Image(systemName: "plus")
                    }
                }
            }
            .sheet(isPresented: $mostrandoCriacao) {
                SecFormView()
                    .environment(\.modelContext, modelContext)
            }
        }
    }
}

#Preview {
    ContentSecView()
        .modelContainer(for: [Jogo.self, JogoNatacao.self], inMemory: true)
}
