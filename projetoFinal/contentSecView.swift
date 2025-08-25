import SwiftUI
import SwiftData

struct ContentSecView: View {
    @Environment(\.modelContext) private var modelContext
    @Query(sort: \Jogo.data) private var jogos: [Jogo]
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(jogos) { jogo in
                    NavigationLink(destination: JogoEditingView(jogo: jogo)
                        .environment(\.modelContext, modelContext)) {
                        JogoCardView(jogo: jogo)
                    }
                }
                .onDelete { indexSet in
                    for index in indexSet {
                        let jogo = jogos[index]
                        modelContext.delete(jogo)
                    }
                }
            }
            .navigationTitle("Jogos")
            .listStyle(.insetGrouped)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    NavigationLink(destination: SecFormView()
                        .environment(\.modelContext, modelContext)) {
                        Image(systemName: "plus")
                    }
                }
            }
        }
    }
}
