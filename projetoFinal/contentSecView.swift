import SwiftUI
import SwiftData

struct ContentSecView: View {
    @Environment(\.modelContext) private var modelContext
    @Query(sort: \Jogo.data) private var jogos: [Jogo]
    @State private var mostrandoCriacao = false
    
    var body: some View {
        NavigationStack {
            ScrollView {
                LazyVStack(spacing: 12) {
                    ForEach(jogos) { jogo in
                        NavigationLink(destination: JogoEditingView(jogo: jogo)
                            .environment(\.modelContext, modelContext)) {
                            JogoCardView(jogo: jogo)
                        }
                        .buttonStyle(PlainButtonStyle()) // remove destaque do NavigationLink
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
