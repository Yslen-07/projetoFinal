import SwiftUI

struct ContentSecView: View {
    @State private var mostrandoForm = false

    
    let jogoExemplo = Jogo(
        curso1: .informatica,
        curso2: .mecanica,
        categoria: .futsal,
        genero: .homem,
        local: "Ginásio Central",
        data: Date(),
        placar1: "4",
        placar2: "5"
    )

    var body: some View {
        NavigationStack {
            VStack {
                JogoCardEdicao(jogo: jogoExemplo)
                    .frame(height: 400)

                Spacer()
            }
            .navigationTitle("Tela de edição esportes")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        mostrandoForm = true
                    } label: {
                        Image(systemName: "plus")
                    }
                }
            }
            .sheet(isPresented: $mostrandoForm) {
                SecFormView()
            }
        }
    }
}

#Preview {
    ContentSecView()
}
